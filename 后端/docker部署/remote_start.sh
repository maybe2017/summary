#!/bin/bash
#============ func  ==================

func_init_javaops(){
    #define jvm_ops
    if [ -n "$1" ]; then
        VAR_JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 $1"
    else
        VAR_JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xmx1g -Xms1g -XX:+UseParallelGC -XX:+UseParallelOldGC"
    fi
}

func_init_nodename(){
    #define app_node in case of clusters/replicates
    if [ -n "$1" ]; then
        VAR_NODE_NAME="$1";
    else
        VAR_NODE_NAME="node_0";
    fi
}

#=================== main  ==============

#init home_path
cd `dirname $0`
VAR_BIN_DIR=`pwd`
cd ..
VAR_DEPLOY_DIR=`pwd`
VAR_CONF_DIR=$VAR_DEPLOY_DIR/conf
VAR_LOG_DIR=$VAR_DEPLOY_DIR/log
VAR_LIB_DIR=$VAR_DEPLOY_DIR/lib
VAR_LIB_JARS=`ls $VAR_LIB_DIR|grep .jar|awk '{print "'$VAR_LIB_DIR'/"$0}'|tr "\n" ":"`


#init log_path
if [ ! -d $VAR_LOG_DIR ]; then
    mkdir $VAR_LOG_DIR
fi

#init java_path
VAR_JAVA_PATH=""
if [ -n "$JAVA_HOME" ]; then
    VAR_JAVA_PATH=$JAVA_HOME/bin/java
else
    VAR_JAVA_PATH="java"
fi

#default init
func_init_nodename
func_init_javaops

#process shell args
ARGS=`getopt -o hj:n: --long help,javaops:,node: -- "$@"`
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$ARGS"
while true;do
    case "$1" in
        -j|--javaops)
            func_init_javaops $2
            shift 2
            ;;
        -n|--node)
            func_init_nodename $2
            shift 2
            ;;
        -h|--help)
            echo "-j | --javaops  set jvm_ops"
            echo "-n | --node     set logging path name for current instance"
            exit 1
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "未知的属性:{$1}"
            exit 1
            ;;
    esac
done

#================== basic user config
MAIN_CLASS="com.iflytek.europa.KomorebiApplication"
USER_JAVA_PROPS=" -Duser.timezone=GMT+8 -Dproject.name=europa-server -DLOG_DIR=$VAR_LOG_DIR -DLOG_NAME=$VAR_NODE_NAME"
#==================

echo "NODE => $VAR_NODE_NAME "
echo "MAIN_CLASS =>  $MAIN_CLASS "
echo "JAVAOPS  => $VAR_JAVA_OPTS "
echo "USER_JAVA_PROPS => $USER_JAVA_PROPS "

#java command
nohup $VAR_JAVA_PATH $VAR_JAVA_OPTS -classpath $VAR_CONF_DIR:$VAR_LIB_JARS $USER_JAVA_PROPS $MAIN_CLASS >/dev/null 2>&1 &

#echo "nohup $VAR_JAVA_PATH $VAR_JAVA_OPTS -classpath $VAR_CONF_DIR:$VAR_LIB_JARS $USER_JAVA_PROPS $MAIN_CLASS"

VAR_PIDS=`ps -f | grep java | grep "$VAR_DEPLOY_DIR" | awk '{print $2}'`

echo "PID: $VAR_PIDS"

