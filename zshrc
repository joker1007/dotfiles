#####################################################################
#
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

###
# Set Shell variable
# WORDCHARS=$WORDCHARS:s,/,,
HISTSIZE=5000 HISTFILE=~/.zhistory SAVEHIST=5000
#PROMPT='%m{%n}%% '
#RPROMPT='[%~]'

# binding keys
bindkey -e
bindkey '^p'	history-beginning-search-backward
bindkey '^n'	history-beginning-search-forward

setopt prompt_subst
nprom () {
    local rbase=$'%{\e[33m%}[%~]%{\e[m%}' lf=$'\n'
    local pct=$'%0(?||%18(?||%{\e[31m%}))%#%{\e[m%}'
    local tm=$'[%T]'
    RPROMPT="%9(~||$rbase)"
    local pbase=$'%{\e[36m%}%U%B%n@%m%b%u'" $tm $pct "
    PROMPT="%9(~|$rbase$lf|)$pbase"
    [[ "$TERM" = "screen" ]] && RPROMPT="[%U%~%u]"
}
nprom


# Set shell options
# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
setopt auto_remove_slash

# ディレクトリの絶対パスがセットされた変数は、そのディレクトリの名前として扱う。
setopt auto_name_dirs 

# history
setopt extended_history hist_ignore_dups hist_ignore_space share_history inc_append_history

# =command を command のパス名に展開する
setopt equals 

# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

# ls -Fと同様に補完候補にタイプ表示
setopt list_types

# beep音無効
setopt no_beep

# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs 

setopt always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups

# C-s, C-qを無効にする
setopt no_flow_control

# cd時に自動でpushd
setopt auto_pushd

# TABで補完候補を切り替える
setopt auto_menu

# Alias and functions
alias copy='cp -ip' del='rm -i' move='mv -i'
alias fullreset='echo "\ec\ec"'
h () 		{history $* | less}
alias ls='ls -F' la='ls -a' ll='ls -la'
mdcd ()		{mkdir -p "$@" && cd "$*[-1]"}
mdpu ()		{mkdir -p "$@" && pushd "$*[-1]"}
alias pu=pushd pd=popd dirs='dirs -v'
alias vi='vim'

# Global aliases
alias -g L="| lv"
alias -g LE="| less"
alias -g G="| grep"

# Suffix aliases(起動コマンドは環境によって変更する)
#alias -s pdf=acroread dvi=xdvi 
#alias -s {odt,ods,odp,doc,xls,ppt}=soffice
#alias -s {tgz,lzh,zip,arc}=file-roller


# 補完システムを利用: 補完の挙動が分かりやすくなる2つの設定のみ記述
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -U compinit && compinit


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# 最後に打ったコマンドステータス行に
if [ "$TERM" = "screen" ]; then
    chpwd () { echo -n "_`dirs`\\" }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2 )); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd
fi



[ -s $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm
