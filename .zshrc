export TERM="screen-256color"
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(git vi-mode debian git-flow tmux vagrant z web-search zsh-syntax-highlighting)

if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

alias 'setfr=setxkbmap fr -option' # (French keyboard layout, no special options)
alias 'setse=setxkbmap se -option' # (Swedish keyboard layout, no special options)
alias 'setca=setxkbmap ca -option' # (Canadian keyboard layout, no special options)

alias tmux='tmux -2'

# Change between English and Danish
#english() {
#    export LANG=en_GB.UTF-8
#    export LANGUAGE=en_GB:en
#}
#danish() {
#    export LANG=da_DK.UTF-8
#    export LANGUAGE=da_DK:da
#}

source $HOME/.gruvbox-palette.sh
source $HOME/.completion.zsh
source $HOME/.zsh_history_substring_search.zsh

# prompt
export RPS1='$(rvm_prompt_info)'
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=false

# for root

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/bin:$HOME/.bin:./bin:$PATH"
export PATH="~/bin:$PATH"
export DEFAULT_USER="vagrant"

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Configuracion POWERLVEL9K
POWERLEVEL9K_MODE='awesome-patched'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=5
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

# Elementos de la barra
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv vi_mode time)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

POWERLEVEL9K_DIR_HOME_BACKGROUND='09'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='09'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='009'
POWERLEVEL9K_DIR_HOME_FOREGROUND='236'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='236'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='236'

# `git hub colors`
#POWERLEVEL9K_VCS_CLEAN_BACKGROUND='236'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='119'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='236'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='214'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='236'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='196'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='236'

# Remove some icons
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

# Vi-Mode
POWERLEVEL9K_VI_INSERT_MODE_STRING='INSERT'
POWERLEVEL9K_VI_COMMAND_MODE_STRING='NORMAL'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='004'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='236'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='245'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='236'

# Context
local user_symbol="%#"
if [ $USERNAME != "vagrant" ]; then
	user_symbol="$user_symbol%n"
fi

if [ $HOST != "ubuntu" ]; then
	user_symbol="$user_symbol@%m"
fi

POWERLEVEL9K_CONTEXT_TEMPLATE="$user_symbol"
