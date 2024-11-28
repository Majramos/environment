#!/usr/bin/env bash

# setup .bashrc configs
if [ ! -f "$HOME/.bashrc" ]; then
    echo ".bashrc not found, creating one"
    echo '#!/usr/bin/env bash' > $HOME/.bashrc
fi

echo "
alias ls='ls -ahoF --group-directories-first --color=always'

alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# Prevents accidentally clobbering files.
alias mkdir='mkdir -pv'

alias ..='cd ..'
" >> $HOME/.bashrc

# setup .bash_profile
if [ ! -f "$HOME/.bash_profile" ]; then
    echo ".bash_profile not found, creating one"
    echo '#!/usr/bin/env bash' > $HOME/.bash_profile
fi

echo '
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# custom prompt
if [ -f "$HOME/.prompt" ]; then
    . "$HOME/.prompt"
fi

# set PATH so it includes users private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes users private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
' >> $HOME/.bash_profile

# TODO: validate to write above to .profile

# setup git prompt
if [ ! -f "$HOME/.prompt" ]; then
    echo ".prompt not found, creating one"
    echo '#!/usr/bin/env bash' > $HOME/.prompt
fi

echo '
# Colors escape codes
NORMAL="\[\033[00m\]"
 BLACK="\[\033[0;30m\]"
   RED="\[\033[0;31m\]"
 GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
  BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
  CYAN="\[\033[0;36m\]"
 WHITE="\[\033[0;37m\]"

DIM_WHITE="\[\033[2;37m\]"

 BACK_BLACK="\[\033[40m\]"
   BACK_RED="\[\033[41m\]"
 BACK_GREEN="\[\033[42m\]"
 BACK_BROWN="\[\033[43m\]"
  BACK_BLUE="\[\033[44m\]"
BACK_PURPLE="\[\033[45m\]"
  BACK_CYAN="\[\033[46m\]"
 BACK_WHITE="\[\033[47m\]"


# detect whether the current directory is a git repository
is_git_repository() {
    git branch > /dev/null 2>&1
}

# get the current branch name of the git repository
get_branch_name() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/"
}

# determine the branch/state information for the git repository
parse_git_branch(){
    git_status="$(git status 2> /dev/null)"

    # set color based on clean/staged/dirty
    if [[ ${git_status} =~ "working tree clean" ]]; then
        state="${GREEN}"
    elif [[ ${git_status} =~ "Changes to be committed" ]]; then
        state="${YELLOW}"
    else
        state="${RED}"
    fi

    # status against remote
    remote_pattern="Your branch is (.*) of"
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
            remote="↑"
        else
            remote="↓"
        fi
    fi
    diverge_pattern="Your branch and (.*) have diverged"
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="↕"
    fi
    updated_pattern="Your branch is up to date with"
    if [[ ${git_status} =~ ${updated_pattern} ]]; then
        remote="√"
    fi

    #name of branch
    branch=$(get_branch_name)

    # set final branch string
    BRANCH="${state} [ ${branch} | ${remote} ]"
}

# set the full bash prompt
set_bash_prompt(){

    # when in a virtual environment in python
    if [[ -z "${VIRTUAL_ENV_PROMPT}" ]]; then  
        PS1=""
    else
        PS1="$VIRTUAL_ENV_PROMPT"
    fi

    # user @ host
    PS1="${CYAN}\u@\h"
    # current working directory
    PS1="$PS1 ${YELLOW}\w"
    # current time in 24-hour HH:MM:SS format
    PS1="$PS1 ${DIM_WHITE}\t"

    if is_git_repository ; then
        # git stuff
        parse_git_branch
        PS1="$PS1${BRANCH}"
    fi

    # new line and $
    PS1="$PS1 ${NORMAL}\n$ "
}

# execute function before displaying prompt
PROMPT_COMMAND=set_bash_prompt
'> $HOME/.prompt
