if type -q zoxide
    zoxide init fish | source
    set -gx _ZO_ECHO 1
end
