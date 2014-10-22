export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history # 履歴ファイルの保存先
HISTSIZE=10000              # メモリに保存される履歴の件数
SAVEHIST=10000              # 指定したファイルに保存される件数
# history検索はCtrl-r

# cdなしでディレクトリ名を直接指定して移動 & ls実行
setopt auto_cd
functionson chpwd() { ls -xACF --color=auto }

# beepを消す
setopt nolistbeep

# 大文字、小文字を区別せず補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 使わないキーの無効化
bindkey -r '^s' # Ctrl-s

# 予測変換
#autoload predict-on
#predict-on

#autoload -U compinit
#compinit

# alias -----------------------------------------------------------
alias gcc='gcc -o'  #(出力ファイル名)(ソースファイル名)でコンパイル

alias rm='rm -i'    # コマンド実行時に一度確認する
alias cp='cp -i'    #               〃
alias mv='mv -i'    #               〃

alias ll='ls -l'    # ファイルの詳細も同時に表示
alias la='ls -A'    # ドットファイルも表示
alias ls='ls -xCF --color=auto'
alias sl='ls -xCF --color=auto'

alias grep='grep --color'   # 検索結果を色付きで表現

alias df='df -h'    # 容量を適当な単位で表示
alias du='du -h'    #           〃

alias open='cygstart'   # ファイルやディレクトリを開く

alias ipconfig='ipconfig | nkf -w'  # 文字化け防止
alias ifconfig='ifconfig | nkf -w'  #       〃
alias getmac='getmac | nkf -w'      #       〃

# prompt -----------------------------------------------------------

# 色有効
autoload -U colors
colors

## 色を使う
setopt prompt_subst

# 補完でカラー使用
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 色を定義
local GREEN=$'%{\e[1;32m%}'
local RED=$'%{\e[1;31m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'

# 通常のプロンプト
PROMPT="
%F{green}[%n@%m]%#%f %F{cyan}[%~]%f
%F{yellow}<<%f "
# 右側のプロンプト。ここでカレントディレクトリを出す。
# RPROMPT="%F{cyan}[%~]%f"
# setopt transient_rprompt


