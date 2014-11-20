. $HOME/.zprezto/runcoms/zshenv

export EDITOR=vim
export PAGER=vimpager

export PATH=/usr/local/share/npm/bin:$HOME/src/go/bin:/usr/local/opt/go/libexec/bin:$HOME/.rbenv/bin:$PATH

export NODE_PATH=$HOME/.node/bin:$HOME/.node/lib/node_modules:$NODE_PATH
export GOPATH=$HOME/src/go
export JAVA_HOME="$(/usr/libexec/java_home)"
export BETTER_ERRORS_EDITOR=macvim

export EC2_HOME="/usr/local/opt/ec2-api-tools/libexec"
export EC2_AMITOOL_HOME="/usr/local/opt/ec2-ami-tools/libexec"
export AWS_IAM_HOME="/usr/local/opt/aws-iam-tools/libexec"
export AWS_CREDENTIAL_FILE=$HOME/.aws-credentials-master

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

[[ -f $HOME/.zsecrets ]] && . $HOME/.zsecrets

export ACADEMIA_APP=$HOME/src/academia-edu/academia-app
export ACADEMIA_CONFIG=$HOME/src/academia-edu/academia-config
export ACADEMIA_SHELL=$HOME/src/academia-edu/academia-shell
export ACADEMIA_LDAP_USERNAME=george
export ACADEMIA_PGSQL=/usr/local/var/postgres
export ACADEMIA_MONGO=/usr/local/var/mongodb
export ACADEMIA_EC2_KEYS=$HOME/src/academia-edu/ec2_keys

