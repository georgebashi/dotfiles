#!/usr/bin/env bash

export BASH_IT="$HOME/.bash_it"
export BASH_IT_THEME='powerline-plain'
export GIT_HOSTING='git@github.com'
unset MAILCHECK
export SCM_CHECK=false
export SHORT_HOSTNAME=$(hostname -s)
export SHORT_TERM_LINE=true

source "$BASH_IT"/bash_it.sh
