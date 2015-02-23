function github_view_auths() {
  read -s password?password:\ 
  curl -s --user joker1007:${password} https://api.github.com/authorizations?per_page=100
}

function github_repo_name() {
  git remote -v | grep origin | cut -f 2 | tail -n 1 | sed -e 's/\.git.*$//' | sed -e 's/.*github\.com[:/]//'
}

function github_repo_api_endpoint() {
  echo "$GITHUB_API_ENDPOINT/repos/$(github_repo_name)"
}

function peco-github-prs () {
  local token=$(git config --get github.token)
  local end_point=$(github_repo_api_endpoint)
  echo "\nfetching pull requests of $(github_repo_name) ..."
  local pr=$(curl -s -H "Authorization: token ${token}" "${end_point}/pulls?per_page=100" | jq -r '.[] |"#\(.number)\t\(.title)\t\(.html_url)"' | peco --query "$LBUFFER" | cut -f 3)
  if [ -n "$pr" ]; then
      BUFFER="open ${pr}"
      zle accept-line
  fi
}
zle -N peco-github-prs
bindkey '^G^P' peco-github-prs
bindkey '^Gp' peco-github-prs

function peco-github-issues () {
  local token=$(git config --get github.token)
  local end_point=$(github_repo_api_endpoint)
  echo "\nfetching issues of $(github_repo_name) ..."
  local issue=$(curl -s -H "Authorization: token ${token}" "${end_point}/issues?per_page=100" | jq -r '.[] |"#\(.number)\t\(.title)\t@\(.assignee.login)\t\(.html_url)"' | peco --query "$LBUFFER" | cut -f 4)
  if [ -n "$issue" ]; then
      BUFFER="open ${issue}"
      zle accept-line
  fi
}
zle -N peco-github-issues
bindkey '^G^I' peco-github-issues
bindkey '^Gi' peco-github-issues
