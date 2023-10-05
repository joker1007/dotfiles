swayidle \
    timeout 1 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' & 
swaylock -c 000000ff
kill %%
