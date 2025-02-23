[ -s ~/.profile ] && source ~/.profile

[ -s ~/.zshenv ] && source ~/.zshenv

if uwsm check may-start; then
  exec systemd-cat -t uwsm_start uwsm start hyprland.desktop
fi

# vim: ft=sh
