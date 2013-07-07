. /Users/georgeb/.zprezto/runcoms/zshrc

alias less=$PAGER
alias zless=$PAGER
unsetopt share_history
setopt inc_append_history

alias qm="mvn -DskipTests -DskipITs -Dmaven.test.skip"
alias qmd="mvnDebug -DskipTests -DskipITs -Dmaven.test.skip"
alias pupcp="rm -rf branches/testing branches/production && cp -r trunk branches/testing && cp -r trunk branches/production"

alias ffs="sudo"

p() { HASTE_SERVER=http://pasti.co haste "$*" | pbcopy; }
