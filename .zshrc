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
  plugins=(vi-mode ant brew bundler dircycle gem git history-substring-search knife mvn osx rbenv redis-cli ruby screen vagrant vundle)
else
  plugins=(vi-mode bundler gem git git-flow ruby svn history-substring-search)
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

export JAVA_HOME="/Library/Java/JavaVirtualMachines/1.7.0.jdk/Contents/Home"

if [ -e ~/bin/saxon9he.jar ]; then
  alias saxon="java -jar ~/bin/saxon9he.jar"
fi
if [ -e ~/bin/jing.jar ]; then
  alias jing="java -jar ~/bin/jing.jar"
fi
alias qm="mvn -DskipTests -DskipITs -Dmaven.test.skip"
alias qmd="mvnDebug -DskipTests -DskipITs -Dmaven.test.skip"
alias pupcp="cp -r trunk/* branches/production/ && cp -r trunk/* branches/testing/"

eval "$(rbenv init -)"
eval "$(fasd --init auto)"
alias v='a -e vim'
alias o='a -e open'


