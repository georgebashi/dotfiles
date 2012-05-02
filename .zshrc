# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
if [[ `uname` == "Darwin" ]]; then
  plugins=(ant brew bundler gem git history-substring-search knife osx rbenv redis-cli ruby vagrant vi-mode vundle)
else
  plugins=(bundler gem git git-flow ruby svn vi-mode)
fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

fpath=($HOME/.zsh/completions $fpath)

export PAGER=vimpager
export EDITOR=vim
export PATH=$HOME/.rbenv/bin:/usr/local/sbin:/usr/local/bin:$PATH
alias less=$PAGER
alias zless=$PAGER
unsetopt correct_all
unsetopt share_history
setopt inc_append_history

if [ -e ~/bin/saxon9he.jar ]; then
  alias saxon="java -jar ~/bin/saxon9he.jar"
fi
if [ -e ~/bin/jing.jar ]; then
  alias jing="java -jar ~/bin/jing.jar"
fi
alias qm="mvn -DskipTests -DskipITs -Dmaven.test.skip"

eval "$(rbenv init -)"

