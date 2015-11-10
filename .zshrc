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

# Git補完
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh/completion $fpath)

# 予測変換
autoload -U compinit
compinit -u

# alias -----------------------------------------------------------
alias ac='apt-cyg'

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
alias pry='pry _0.10.1_'

alias ipconfig='ipconfig | nkf -w'  # 文字化け防止
alias ifconfig='ipconfig | nkf -w'  #       〃
alias getmac='getmac | nkf -w'      #       〃
alias netstat='netstat -r | nkf -w'
alias ping='cocot ping'

alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

alias tw='ruby ~/desktop/SLP/Twitter-app/tweet_own.rb'      # Twitterで呟く
alias tl='ruby ~/desktop/SLP/Twitter-app/look_tweet.rb'     # TLを見る
alias ts='ruby ~/desktop/SLP/Twitter-app/search_tweet.rb'   # ツイート検索
alias nl='ruby ~/desktop/SLP/Twitter-app/look_news.rb'      # ニュースを見る

# prompt -----------------------------------------------------------

# 色を有効化
autoload -U colors
colors

# 色を使う
setopt prompt_subst

# 補完でカラーを使用
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

# 右側のプロンプト
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

# 実験用
#PROMPT="
#[%n@%m]%# "

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
