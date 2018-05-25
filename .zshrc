# set up zplugin
local -A ZPLGM
ZPLGM[HOME_DIR]="${ZDOTDIR:-$HOME}/.zplugin"
source "${ZPLGM[HOME_DIR]}/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# prezto base
zplugin snippet PZT::modules/environment/init.zsh

zstyle ':prezto:module:terminal' auto-title 'yes'
zplugin snippet PZT::modules/terminal/init.zsh

zstyle ':prezto:module:editor' key-bindings 'vi'
zplugin snippet PZT::modules/editor/init.zsh

zplugin snippet PZT::modules/history/init.zsh

zplugin snippet PZT::modules/directory/init.zsh

zstyle ':prezto:module:utility:ls' color 'yes'
zplugin snippet PZT::modules/utility/init.zsh

# git
zplugin ice wait"0" lucid
zplugin snippet PZT::modules/git/alias.zsh
zplugin ice wait"0" lucid
zplugin snippet PZT::modules/git/init.zsh

# completions
if [[ -d /usr/local/Homebrew/completions/zsh ]]; then
  zplugin ice wait"1" lucid
  zplugin light /usr/local/Homebrew/completions/zsh
fi
zplugin ice wait"0" lucid
zplugin light zsh-users/zsh-completions

# fzf
if (( $+commands[fzf] )); then
  zplugin ice wait"0" lucid src"shell/key-bindings.zsh" pick"shell/completion.zsh"
  zplugin light junegunn/fzf
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND="fd . ."
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd -t d . ."
  fi
  #bindkey '\eOA' fzf-history-widget
  #bindkey '\eOB' fzf-history-widget
fi

# iterm
if [[ "$TERM_PROGRAM" = "iTerm.app" ]]; then
  zplugin snippet OMZ::plugins/iterm2/iterm2.plugin.zsh
  zplugin snippet https://iterm2.com/shell_integration/zsh
  export GEOMETRY_PROMPT_PREFIX="%{$(iterm2_prompt_mark)%}"
else
  export GEOMETRY_PROMPT_PREFIX=""
fi

# ruby
if (( $+commands[rbenv] )); then
  zplugin snippet PZT::modules/ruby/init.zsh
fi

# syntax highlighting
zplugin ice wait"0" lucid atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

# prompt
export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
export PROMPT_GEOMETRY_COLORIZE_ROOT=true
export PROMPT_GEOMETRY_EXEC_TIME=true
export PROMPT_GEOMETRY_GIT_TIME=false
export GEOMETRY_PLUGIN_HOSTNAME_PREFIX=" "
export GEOMETRY_GIT_SEPARATOR="·"
export GEOMETRY_PROMPT_PLUGINS_PRIMARY=(path hostname)
export GEOMETRY_PROMPT_PLUGINS_SECONDARY=(exec_time git jobs virtualenv)

export GEOMETRY_SYMBOL_PROMPT="❯"
export GEOMETRY_SYMBOL_ROOT="❯"

export GEOMETRY_PROMPT_PREFIX_SPACER=""
zplugin light geometry-zsh/geometry

# vimpager
if (( $+commands[vimpager] )); then
  export PAGER=vimpager
  alias less=$PAGER
  alias zless=$PAGER
fi

# neovim
if (( $+commands[nvim] )); then
  export EDITOR=nvim
  export VISUAL=nvim
  alias vi=$EDITOR
  alias vim=$EDITOR
fi

# secrets
[[ -f $HOME/.zsecrets ]] && . $HOME/.zsecrets

# sbin in path
[[ -d /usr/local/sbin ]] && export PATH=/usr/local/sbin:$PATH

# config alias
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

:
