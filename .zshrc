[[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]] && source ${ZDOTDIR:-${HOME}}/.zim/init.zsh

# vim: set ft=zsh et ai sw=2 sts=2:
export PAGER=vim
alias less=$PAGER
alias zless=$PAGER
unsetopt share_history
setopt inc_append_history

# props to @matthewfranglen, the mad bastard
function vim-ctrlp () {
  BUFFER="vim '+:Unite -no-split file_rec/git:--others:--exclude-standard:--cached'"
  zle accept-line
}
zle -N vim-ctrlp
bindkey '^P' vim-ctrlp

function fg-or-run-vim () {
  if [[ $#jobstates -eq 0 ]]; then
    BUFFER='vim'
    zle accept-line
  else
    BUFFER='fg'
    zle accept-line
  fi
}
zle -N fg-or-run-vim
bindkey '^Z' fg-or-run-vim

function tab_color() {
  echo -ne "\033]6;1;bg;red;brightness;$1\a"
  echo -ne "\033]6;1;bg;green;brightness;$2\a"
  echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

function reset_tab_color() {
  echo -ne "\033]6;1;bg;*;default\a"
}

function set_tab_color_for_cmd() {
  case "$1" in
    vim*|vi\ *)
      tab_color 0 127 0
      ;;
    ssh*)
      tab_color 245 190 25
      ;;
    rails\ *)
      tab_color 152 26 33
      ;;
    foreman\ *)
      tab_color 153 153 153
      ;;
    bundle*)
      tab_color 198 231 236
      ;;
    mongod*)
      tab_color 64 40 23
      ;;
    vagrant*)
      tab_color 72 180 251
      ;;
  esac
}

add-zsh-hook precmd reset_tab_color
add-zsh-hook preexec set_tab_color_for_cmd

alias vi="nvim"
alias vim="nvim"
alias ffs="sudo"

alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
