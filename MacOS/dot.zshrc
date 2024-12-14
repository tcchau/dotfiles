################################################################################
#
# My own customizations
# stty commands have to precede the p10k instant prompt
# to avoid warnings about instant prompt errors if there is console i/o after
# powerlevel10k is loaded.
#
################################################################################
stty -ixon

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="jonathan"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#############################################
###
### my custom sections
###
#############################################

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
export PATH=$HOME/bin:$PATH


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

# VIM key bindings for command line editing
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
export LESS="-F -E -X $LESS"

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

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# requires higher limit on file handles for model training in python
ulimit -n 10240

# plain mode without plugins
alias vi="vim -u NONE"

#####
##### Platform-specific changes
#####
if [[ $(uname) == "Darwin" ]]; then
  ### FZF stuff
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='fd --type f --follow'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home

  # for jenv, java runtime version manager
  # export PATH="/usr/local/bin:/usr/local/opt:./node_modules/.bin:$PATH"
  # export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  # export PATH="$HOME/.jenv/bin:$PATH"
  # eval "$(jenv init -)"

  #
  # tabtab source for serverless package
  # uninstall by removing these lines or running `tabtab uninstall serverless`
  [[ -f /Users/clinton/.nvm/versions/node/v8.1.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/clinton/.nvm/versions/node/v8.1.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
  # tabtab source for sls package
  # uninstall by removing these lines or running `tabtab uninstall sls`
  [[ -f /Volumes/GitRepositories/Peekapak/MicroServices/node_modules/tabtab/.completions/sls.zsh ]] && . /Volumes/GitRepositories/Peekapak/MicroServices/node_modules/tabtab/.completions/sls.zsh

fi

if [[ $(uname) == "Linux" ]]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# install path for Deno if directory exists
if [[ -d "$HOME/.deno/bin" ]]; then
  export DENO_INSTALL="/Users/clinton/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

# pyenv initialization
eval "$(pyenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# shorthand for cryptic names
export SHFCNMYPTEST="E2PI9QSGISSB91"
export SHFCNMYPPROD="EH1W8JVUBQYBG"
export SHFCNMYPSTAGING="EYZUOGFZ946FS"
export SHFCNAPPLINKS="E38OLWYI3JK9QI"
export SHFCNTESTSERVER="ENFAM4V3M8AF4"
export SHFCNPRODSERVER="E2H3KFPE4RR29K"
export SHFCNBUNDLESERVER="E3CLVRNS82V2IW"
export SHFCNPRODUSERPOOL="us-east-1_FJFi3AIyn"
export SHFCNDEVUSERPOOL="us-east-1_OXXptQxZt"

# aliases for using different configurations of neovim
vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}
