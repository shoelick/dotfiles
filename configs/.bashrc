# ~/.bashrc

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

# Set up local dependencies first
if [ -f ~/.bashlocalrc ]; then
    source ~/.bashlocalrc
fi

### COLORS ###

export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[1;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

### TERMINAL PROMPT ###

export PS1="\[\e[1;36m\]\D{%a %d-%m}\[\e[m\] (\[\e[1;35m\]\u@\h\[\e[m\]) : \[\e[1;32m\]\w\[\e[m\]\[${COLOR_LIGHT_CYAN}\]\$(__git_ps1 \" %s\")\[${COLOR_NC}\] "
export PS2='> '
export PS3='#? '
export PS4='+ '

### ALIASES ###

alias vi=nvim
alias vim=nvim
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export CLICOLOR='1'

alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
export LSCOLORS="gxDxFxdxCxExExhbadgxgx"

### GIT ALIASES ###

alias gss='git status '
alias ga='git add '
alias gap='git add --patch'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '

### BASH HISTORY ###

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[1;5C":forward-word'
bind '"\e[1;5D":backward-word'
shopt -s histappend
PROMPT_COMMAND='history -a'

# Number of lines to keep in the history file
export HISTSIZE=1000000
# bash history is timestamped as YYYY-MM-DD HH:MM:SS
export HISTTIMEFORMAT='%F %T '
# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

##############################

# After each command, update LINES and COLUMNS to reflect the current window size
shopt -s checkwinsize
