. /Users/georgeb/.zprezto/runcoms/zshrc

alias less=$PAGER
alias zless=$PAGER
unsetopt share_history
setopt inc_append_history

. /usr/local/opt/go/misc/zsh/go

if [ -e ~/bin/saxon9he.jar ]; then
  alias saxon="java -jar ~/bin/saxon9he.jar"
fi
if [ -e ~/bin/jing.jar ]; then
  alias jing="java -jar ~/bin/jing.jar"
fi
alias qm="mvn -DskipTests -DskipITs -Dmaven.test.skip"
alias qmd="mvnDebug -DskipTests -DskipITs -Dmaven.test.skip"
alias pupcp="rm -rf branches/testing branches/production && cp -r trunk branches/testing && cp -r trunk branches/production"

#alias ga="git add"
#alias gst="git status"
alias ffs="sudo"

p() { HASTE_SERVER=http://pasti.co haste "$*" | pbcopy; }
