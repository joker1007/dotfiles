#!/bin/bash

# Function to display usage
usage() {
  echo "Usage: $0 --item-name <1password-item-name> [--role-arn <role-arn>] [--mfa-serial <mfa-serial>] [--mfa-item-name <mfa-item-name>]"
  exit 1
}

# Initialize variables
ITEM_NAME=""
ROLE_ARN=""
MFA_SERIAL=""
MFA_ITEM_NAME=""

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --item-name)
      ITEM_NAME="$2"
      shift 2
      ;;
    --role-arn)
      ROLE_ARN="$2"
      shift 2
      ;;
    --mfa-serial)
      MFA_SERIAL="$2"
      shift 2
      ;;
    --mfa-item-name)
      MFA_ITEM_NAME="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
done

# Check if ITEM_NAME is provided
if [ -z "$ITEM_NAME" ]; then
  usage
fi

# --- Main Logic ---

# If a MFA_SERIAL is not provided, just fetch the base credentials from 1Password.
if [ -z "$MFA_SERIAL" ]; then
  op item get "$ITEM_NAME" --fields "label=aws_access_key_id,label=aws_secret_access_key" --reveal --format=json | jq "{Version: 1, AccessKeyId: .[0].value, SecretAccessKey: .[1].value}"
  exit 0
fi

# --- Assume Role with Session Token Logic ---

# 1. Get base credentials from 1Password.
creds_json=$(op item get "$ITEM_NAME" --fields "label=aws_access_key_id,label=aws_secret_access_key" --reveal --format=json)
if [ $? -ne 0 ]; then
  echo "Error: Failed to fetch base credentials from 1Password for item '$ITEM_NAME'." >&2
  exit 1
fi

# 2. Export base credentials for the aws cli to use.
export AWS_ACCESS_KEY_ID=$(echo "$creds_json" | jq -r '.[0].value')
export AWS_SECRET_ACCESS_KEY=$(echo "$creds_json" | jq -r '.[1].value')
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ "$AWS_ACCESS_KEY_ID" == "null" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ] || [ "$AWS_SECRET_ACCESS_KEY" == "null" ]; then
    echo "Error: Failed to parse AWS credentials from 1Password JSON output." >&2
    exit 1
fi

# 3. Get a session token (with MFA if required).
SESSION_TOKEN_ARGS=()
if [ -n "$MFA_SERIAL" ]; then
  if [ -z "$MFA_ITEM_NAME" ]; then
    echo "Error: --mfa-item-name is required when --mfa-serial is provided." >&2
    exit 1
  fi
  
  MFA_TOKEN=$(op item get "$MFA_ITEM_NAME" --otp --cache=false)
  if [ $? -ne 0 ] || [ -z "$MFA_TOKEN" ]; then
      echo "Error: Failed to fetch MFA token from 1Password for item '$MFA_ITEM_NAME'." >&2
      exit 1
  fi
  SESSION_TOKEN_ARGS+=(--serial-number "$MFA_SERIAL" --token-code "$MFA_TOKEN")
fi

session_token_json=$(aws sts get-session-token "${SESSION_TOKEN_ARGS[@]}")
if [ $? -ne 0 ]; then
  echo "Error: 'aws sts get-session-token' command failed." >&2
  exit 1
fi

if [ -z "$ROLE_ARN" ]; then
  # If no ROLE_ARN is provided, just return the session token credentials.
  echo "$session_token_json" | jq '.Credentials | {Version: 1, AccessKeyId: .AccessKeyId, SecretAccessKey: .SecretAccessKey, SessionToken: .SessionToken, Expiration: .Expiration}'
  exit 0
fi

# 4. Use the session token to assume the role.
# Export the temporary session credentials for the next AWS CLI call.
export AWS_ACCESS_KEY_ID=$(echo "$session_token_json" | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo "$session_token_json" | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo "$session_token_json" | jq -r '.Credentials.SessionToken')
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ "$AWS_ACCESS_KEY_ID" == "null" ]; then
    echo "Error: Failed to parse AccessKeyId from get-session-token output." >&2
    exit 1
fi

# 5. Call assume-role.
ROLE_SESSION_NAME="aws-credential-helper-$(date +%s)"
assumed_role_json=$(aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name "$ROLE_SESSION_NAME")
if [ $? -ne 0 ]; then
  echo "Error: 'aws sts assume-role' command failed." >&2
  exit 1
fi

# 6. Format the final output from assume-role.
echo "$assumed_role_json" | jq '.Credentials | {Version: 1, AccessKeyId: .AccessKeyId, SecretAccessKey: .SecretAccessKey, SessionToken: .SessionToken, Expiration: .Expiration}'
