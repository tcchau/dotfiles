# Path to your oh-my-zsh installation.
export ZSH=/Users/clinton/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
export PATH="/usr/local/bin:/usr/local/opt:./node_modules/.bin:$PATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
################################################################################
#
# My own customizations
#
################################################################################
DEFAULT_USER="clinton"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
stty -ixon
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# my environment variables
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
export LESS="-F -E -X $LESS"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/clinton/.nvm/versions/node/v8.1.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/clinton/.nvm/versions/node/v8.1.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh

# turn off autopushd so that we use the dir stack manually
unsetopt autopushd
unsetopt inc_append_history
unsetopt share_history

alias rmnpmd="find . -name 'npm-debug*' -exec rm {} \;"
alias gitprunelocal="git branch --merged master | grep -v '\* master' | xargs -n 1 git branch -d"
alias gitpruneremote="git remote prune origin"
alias sls="../mysls.sh"
alias gitlastlog="git log -1 --pretty=%B"

function gitchangelog() {
  if [[ -n $1 ]] ; then
    git log --grep="Merge branch" $1..HEAD
  else
    echo "Requires commit hash as argument"
  fi
}

function fif() {
  if [[ -n $1 && -n $2 ]] ; then
    find . -name $1 -exec grep -Hin $2 {} \;
  else
    echo "Requires 2 patterns as arguments"
  fi
}

function rmd() {
  pandoc $1 | lynx -stdin
}

function reapdockerimages() {
  docker rm $(docker ps -qa --no-trunc --filter "status=exited")
  docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
  docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
}

function list-unmerged {
  git ls-files --unmerged | cut -f2 | sort -u ;
}

alias add-unmerged="list-unmerged | xargs git add"

alias edit-unmerged="list-unmerged | xargs vim"

# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Volumes/GitRepositories/Peekapak/MicroServices/node_modules/tabtab/.completions/sls.zsh ]] && . /Volumes/GitRepositories/Peekapak/MicroServices/node_modules/tabtab/.completions/sls.zsh
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/clinton/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/clinton/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# for jenv, java runtime version manager
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
