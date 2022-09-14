export ZSH="${HOME}/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

if type sheldon > /dev/null 2>&1; then
  eval "$(sheldon source)"
elif type cargo > /dev/null 2>&1; then
  echo "install sheldon"
  cargo install sheldon
fi

