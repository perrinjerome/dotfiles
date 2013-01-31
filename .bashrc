# .bashrc

# disable XON,XOFF
stty -ixon

# source local config, if any
[ -f ~/.local/.bashrc ] && . ~/.local/.bashrc
[ -z $PS1_BASE ] && PS1_BASE='$'

# automatic screen not really working
#[ x$SSH_TTY != x ] && [ x$SCREENDIR != x ] && screen -x


BLUE="\[\033[0;34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_BLUE="\[\033[1;34m\]"
LIGHT_CYAN="\[\033[1;36m\]"
YELLOW="\[\033[1;33m\]"
WHITE="\[\033[1;37m\]"
RED="\[\033[0;31m\]"
NO_COLOUR="\[\033[0m\]"

# dynamic prompt: in red if having backgrounded jobs, and with a different char
# if under midnight commander.
function prompt_func() {
  JOBS=`jobs -s | wc -l`
  if test -z $MC_SID; then
    if test $JOBS \< 1; then
      echo "$PS1_BASE ";
    else
      echo -en "\033[0;31m$PS1_BASE \033[0m";
    fi;
  else
    echo "$PS1_BASE_ ";
  fi;
}

# If running interactively, then:
if [ "$PS1" ]; then

    # don't put duplicate lines in the history. See bash(1) for more options
    export HISTCONTROL=ignoredups
    shopt -s histappend
    HISTIGNORE="[   ]*:&:bg:fg:ls:cd:l:s:p:*reboot"
    HISTSIZE=9000
    HISTFILESIZE=9000
    # enable color support of ls and also add handy aliases
    eval `dircolors -b`
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'

    # set a fancy prompt
    PS1="\$(prompt_func)"

    case $TERM in
	linux*)
	    ;;

	dumb*)
	    alias ls=ls 
	    ;;
	*)
	    PROMPT_COMMAND='history -a; echo -ne "\033]0;${USER}@${PWD}\007"'
	    ;;
    esac

    source ~/.git-completion.bash
fi

############################ FONCTIONS ########################################

function lll(){
    ls -alh --color $* | more
}

function psgrep(){
	ps ax | grep $1 | grep -v grep
}

function pskill(){
	local pid
	pid=$(ps ax | grep $1 | grep -v grep  | awk '{ print $1 }')
	echo -n "killing $1 (process $pid)..."
	kill -9 $pid
	echo "slaughtered."
}

function srcgrep(){
  grep $* `find . -name "*.cpp"`\
      `find . -name "*.hpp"`\
      `find . -name "*.c"`\
      `find . -name "*.h"`\
      `find . -name "*.py"`\
      `find . -name "*.el"`  
}

function calc {
  echo "${1}" | bc -l;
}

function urxvt-copy-termcap {
  infocmp rxvt-unicode | ssh $1 "mkdir -p .terminfo && cat >/tmp/ti && tic
  /tmp/ti"
}

#### EXPORTS ###########################################
##//CD-RECORD
export CDR_DEVICE=ATAPI:0,0,0
export CDR_SPEED=4
export CDR_FIFOSIZE=16*1024k

[ -z "$HOST" ] && export HOST=${HOSTNAME}
export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin/
export ZIPOPT='-n .gif -n .zip -n .gz -n .bz2 '
export BROWSER='/home/jerome/firefox/firefox'
export EDITOR='vim'
export SDL_AUDIODRIVER=esd 
export PATH=$PATH:/sbin:/usr/sbin:~/scripts/
export PYTHONSTARTUP=~/.pythonstartup 
export LESSOPEN="|lesspipe.sh %s";
export MAIL=$HOME/Maildir/
export MOZILLA_FIVE_HOME=/usr/lib/mozilla-firefox-1.0.2/


[ $TERM = Eterm ] && {
    alias mc="mc -a"
    export LANG=fr_FR
}

# LLP2
export LLP2_HOME=/opt/java/LLP2/
export PATH=$LLP2_HOME/etc/scripts/unix/:$PATH
export XTAGIMPORT_HOME=~/place/00STAGE/stage/XTAGIMPORT/

# MOZART
export OZHOME=/usr/lib/mozart/
export PATH=$PATH:$MOZART_HOME/bin

# CVS
export CVS_RSH=ssh
export CVSROOT=/opt/CVS/
export CVSEDITOR=vi
export CVSUMASK=002


#### ALIASES ##########################################
alias vim='SESSION_MANAGER= vim'
alias df="df -h"
alias du="du -h"
alias cd..='cd ..'
alias more=less
alias pdw=pwd
alias vi=vim
alias rm='rm -i'
alias p='cd "$OLDPWD"'
alias s='cd ..'
alias l='ls'
alias ll='ls -al'
alias d=disown
alias sudo="sudo -H"
alias emacsnw="/usr/bin/emacs -nw "
alias vi-='vi -'

### COMMANDES ##########################################

### BASH OPTIONS
shopt -u mailwarn

## Keychain pour tapper qu'1 fois le pass ssh
#keychain --noask -q
#host=`uname -n`
#[ -f $HOME/.keychain/$host-sh ] &&  . $HOME/.keychain/$host-sh
#[ -f $HOME/.keychain/$host-sh-gpg ] && . $HOME/.keychain/$host-sh-gpg

# fortunes
#[ -z "$SSH_CONNECTION" ] && [ -f /etc/mandriva-release ] && {
#    echo
#    fortune | iconv -f latin1
#    echo 
#}
#[ -z "$SSH_CONNECTION" ] && [ -f /etc/debian_version ] && {
#    echo
#    /usr/games/fortune all
#    echo 
#}

# grep en couleur
export GREP_COLOR="01;34"
alias grep="grep --color"
 
# java/eclipse
export JAVA_HOME=/opt/java/jre1.6.0_17
export JAVA_HOME=/opt/java/jdk1.6.0_21
export PATH=${JAVA_HOME}/bin/:$PATH
export ANT_HOME=/opt/java/apache-ant-1.6.5/
export ANT_HOME=/opt/java/apache-ant-1.8.1/
export JONAS_ROOT=/opt/java/JONAS_4_2_3/
export PATH=$PATH:$ANT_HOME/bin/
alias eclipse=/opt/eclipse/eclipse
alias protege=/opt/java/Protege_2.1/Protege
alias soaeditor=/mnt/linux3/opt/java/SOAEditor/soaeditor.sh
alias fop=/opt/java/fop-0.20.5/fop.sh
alias xalan=/opt/java/fop-0.20.5/xalan.sh
alias jython=/opt/java/jython-2.1/jython
alias jythonc=/opt/java/jython-2.1/jythonc
export PATH=$PATH:/opt/java/apache-maven-2.2.1/bin/

# DBXML
export DBXML_CLASSPATH=/opt/dbxml-2.0.9/install/lib/db.jar:/opt/dbxml-2.0.9/install/lib/dbxml.jar
export CLASSPATH=.:$CLASSPATH:$DBXML_CLASSPATH

# MAXQ
MAXQ_DIR=/home/jerome/place/work/test/maxq
MAXQ_CLASSPATH=${MAXQ_DIR}/lib/maxq.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/commons-cli.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/commons-collections-3.1.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/commons-httpclient.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/commons-lang.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/commons-logging.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/httpunit-1.6.1-maxq1.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/junit.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/log4j-1.2.8.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/rhino-1.6R1.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/Tidy.jar
MAXQ_CLASSPATH=${MAXQ_CLASSPATH}:${MAXQ_DIR}/lib/velocity-1.4.jar
export CLASSPATH=${CLASSPATH}:${MAXQ_CLASSPATH}

TOMCAT_CLASSPATH=
TOMCAT_JAR_PATH="/opt/java/lib/"
if [ -d "$TOMCAT_JAR_PATH" ]; then
  for i in "$TOMCAT_JAR_PATH"/*.jar; do
    TOMCAT_CLASSPATH="$TOMCAT_CLASSPATH":"$i"
  done
fi
export CLASSPATH=${CLASSPATH}:${TOMCAT_CLASSPATH}

## LD_LIBRARY_PATH
export LD_LIBRARY_PATH

[ -f /etc/bash_completion ] && . /etc/bash_completion
[ -f ~/.secret ] && source ~/.secret
ulimit -S -c 0


function make_local_prefix() {
  PREFIX=$1
  export LD_LIBRARY_PATH=$PREFIX/lib/:$LD_LIBRARY_PATH
  export PATH=$PREFIX/bin/:$PATH
  export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/:$PKG_CONFIG_PATH
}

make_local_prefix  /home/jerome/.local/ 
make_local_prefix  /home/jerome/.local/arm-elf/
make_local_prefix  /usr/local/

function cvsdiff () { cvs diff $@ | colordiff |less -R; }
function svndiff () { svn diff $@ | colordiff |less -R; }
set bell-style none

export PATH="/home/jerome/.local/bin:$PATH"
export ORACLE_HOME=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server/
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib/
export PATH=$ORACLE_HOME/bin:$PATH

export OOO_FORCE_DESKTOP=gnome
export SAL_USE_VCLPLUGIN=gtk

keychain -q --nogui --host localhost /home/jerome/.ssh/id_dsa 
#                                     /home/jerome/.ssh/id_rsa
. ~/.keychain/localhost-sh
. ~/.keychain/localhost-sh-gpg

export LESSCOLORIZER=pygmentize  
alias lv="less -r"
export GREP_OPTIONS="--exclude=\*.svn\*"

cd() { builtin cd "$@"; echo $PWD; ls; };

export DEVKITPRO=/home/jerome/perso/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PAPATH=$DEVKITPRO/PAlib/lib

export CCACHE_SIZE="4G"
export CCACHE_DIR="/home/jerome/tmp/ccache"

