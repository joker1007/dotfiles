#####################################################################
#
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

###
# Set Shell variable

# CTRL-wでパスの削除ができるように
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' 

# history
HISTSIZE=5000 HISTFILE=~/.zhistory SAVEHIST=5000
#PROMPT='%m{%n}%% '
#RPROMPT='[%~]'


# binding keys
bindkey -e
bindkey '^p'	history-beginning-search-backward
bindkey '^n'	history-beginning-search-forward

# CTRL+zでbgのvimに復帰する
bindkey -s '^z' '^[q %vim^m'

# ESC+Gでtar xvzf と入力
bindkey -s '^[G' 'tar xvzf '

# ESC+:で"**/*(.)"を入力
bindkey -s '^[:' '**/*(.)'


# LS_COLORS (from CentOS)
unset LS_COLORS
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:'

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
# 日本語の文字化けを防ぐ
setopt print_eight_bit

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

# 補完候補を詰める
setopt list_packed

# beep音無効
setopt no_beep

# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs 

# 補完候補表示後、元のプロンプトに戻る
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
alias screen='screen -s zsh'

# enable color support of ls and also add handy aliases
alias ls='ls -F --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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
# 補完有効化
autoload -U compinit && compinit

# 補完キャッシュ
zstyle ':completion:*' use-cache true

# 補完メニューをカーソル等で選択できるようにする
zstyle ':completion:*' menu select=2

# 補完の大文字・小文字を区別しない。が、大文字を入力したときは区別する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sudo時も$PATH内のコマンドを補完する
zstyle ':completion:*:sudo:*' command-path ${(s.:.)PATH}

# process補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# % zmv '(*).jpeg' '$1.jpg'
# % zmv '(**/)foo(*).jpeg' '$1bar$2.jpg'
# % zmv -n '(**/)foo(*).jpeg' '$1bar$2.jpg' # 実行せずパターン表示のみ
# % zmv '(*)' '${(L)1}; # 大文字→小文字
# % zmv -W '*.c.org' 'org/*.c' #「(*)」「$1」を「*」で済ませられる
autoload zmv
autoload zargs

# コマンドラインを$EDITORで編集
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# 最後に打ったコマンドをscreenのウィンドウタイトルに
if [ "$TERM" = "xterm-256color" ]; then
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

# Puttyタイトルバー用設定
case "${TERM}" in
  kterm*|xterm)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${SHELL}\007"
    }
    ;;
  xterm-256color|screen)
    precmd() {
      echo -ne "\033P\033]0;${USER}@${HOST%%.*}:${SHELL}\007\033\\"
    }
    ;;
esac


[ -s $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm
