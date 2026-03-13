# pecoとghqでローカルのリポジトリクローンに飛ぶ
function peco-src
    set -l selected_dir (ghq list --full-path | peco --query (commandline -b))
    if test -n "$selected_dir"
        cd $selected_dir
        commandline -f repaint
    end
end

function peco-git-checkout
    set -l branch (git branch -a | peco | string trim | string replace '*' '')
    if test -n "$branch"
        if string match -q '*remotes/*' $branch
            set -l b (echo $branch | awk -v OFS='/' -F'/' '{print $2,$3}')
            commandline -i $b
        else
            commandline -i $branch
        end
    end
end

function peco-git-log
    set -l res (git log --all --graph --oneline --decorate=full -n 300 | peco | awk '{print $2}')
    if test -n "$res"
        commandline -i $res
        commandline -f end-of-line
    end
end

function cdgem
    set -l query $argv[1]
    set -l gem_name (bundle list | sed -e 's/^ *\* *//g' | peco --query=$query | cut -d ' ' -f 1)
    if test -n "$gem_name"
        set -l gem_dir (bundle show $gem_name)
        echo "cd to $gem_dir"
        cd $gem_dir
    end
end

function swgemfile
    set -l gemfile (find . \( -name "Gemfile*" -or -name "*.gemfile" \) -not -name "*.lock" -maxdepth 2 | peco)
    if test -n "$gemfile"
        set -l gemfile_fullpath (echo $gemfile | ruby -r pathname -ne 'puts Pathname(Dir.pwd).join($_)')
        touch .envrc
        sed -i -e '/BUNDLE_GEMFILE/d' .envrc
        echo "export BUNDLE_GEMFILE=$gemfile_fullpath" >> .envrc
        direnv allow .
        direnv reload
    else
        sed -i -e '/BUNDLE_GEMFILE/d' .envrc
        direnv allow .
        direnv reload
    end
end
abbr --add swg swgemfile

function peco-rake
    set -l taskname (rake -W | cut -f 1,2 -d ' ' | uniq | peco | cut -f 2 -d ' ')
    if test -n "$taskname"
        echo "Execute \"rake $taskname\""
        rake $taskname
    end
end
abbr --add rp peco-rake

function peco-history
    set -l res (history | peco --prompt "HISTORY>")
    if test -n "$res"
        commandline -r $res
        commandline -f end-of-line
    end
end

function peco-file
    set -l res (find . -name "*$argv[1]*" | grep -v '/\.' | peco)
    if test -n "$res"
        commandline -i $res
        commandline -f end-of-line
    end
end

function peco-ps
    set -l res (ps aux | peco | awk '{print $2}')
    if test -n "$res"
        commandline -i $res
        commandline -f end-of-line
    end
end

function peco-ssh
    set -l res (grep "Host " ~/.ssh/config | cut -b 6- | peco)
    if test -n "$res"
        commandline -r "ssh $res"
        commandline -f end-of-line
    end
end

function peco-ssh-xpanes
    set -l res (grep "Host " ~/.ssh/config | cut -b 6- | peco | tr '\n' ' ')
    if test -n "$res"
        commandline -r "xpanes --log=~/log --ssh $res"
        commandline -f end-of-line
    end
end

function __peco_key_bindings --on-event fish_prompt
    bind escape,g peco-src
    bind escape,b peco-git-checkout
    bind escape,l peco-git-log
    bind \cr peco-history
    bind escape,f peco-file
    bind escape,p peco-ps
    bind escape,s peco-ssh
    bind escape,x peco-ssh-xpanes
end
