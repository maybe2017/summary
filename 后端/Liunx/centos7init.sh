#!/bin/bash
#####################################################
# Description:
# CentOS 7.x系统安装后初始化脚本。
#
# Attentions:
# 在云主机（如阿里云）上执行时，需要根据实际环境，使用合适的DNS/Yum源/NTP等服务。
# 
#
#####################################################
# Revision History:
# Version       Author(s)          YYYY-MM-DD   Comments
# v1.0          Li Changshui       2019-01-29   Initial version
# v1.1          Li Changshui       2019-02-21   Added package tcpdump.x86_64, iftop.x86_64, htop.x86_64
#                                               Removed disabling the ipv6 module
# v1.1(1)       Li Changshui       2019-03-11   Modified for IPTV remote access.
#
#####################################################
#
### Variable parameter

VERSION=1.0
CUR_PATH=`dirname $0`
HOME_PATH=`cd ${CUR_PATH}; pwd`
OS_TYPE="Linux"
OS_VERSION="7"
RELEASENAME="S1901CentOS7.XOptimizing1.0"
TAG="S:LINUX:"${RELEASENAME}":2019/01/23:`date "+%Y/%m/%d %T"`"

WORK_USER=iptv
WORK_UID=511
WORK_GID=511
NTP_SVC="ntp1.aliyun.com"
BASE_REPO="http://mirrors.aliyun.com/repo/Centos-7.repo"
EPEL_REPO="http://mirrors.aliyun.com/repo/epel-7.repo"

TIME=`date +%F_%H-%M-%S`
PROG_LOG="$HOME_PATH/install_$TIME.log"

####################### Special Function ########################
# Remove the existing logs
#rm -f $PROG_LOG

#####【准备工作】
color_theme(){
    RED_COLOR='\E[1;31m'   
    GREEN_COLOR='\E[1;32m' 
    YELLOW_COLOR='\E[1;33m' 
    RES='\E[0m'
}

### Check before installed
pre_install_check()
{
    test -d /var/systag/version/ || mkdir -p /var/systag/version/
    grep ${RELEASENAME} /var/systag/version/sys_tuning.txt >/dev/null 2>&1 && { echo_failure; echo; echo -e "${YELLOW_COLOR} WARNING: Release $RELEASENAME has already been installed. ${RES}"; exit 1; }
    #Check to see if you are on linux
    echo -n "Checking OS type ... "
    OS=`cat /etc/centos-release | awk '{print $(NF-1)}' | awk -F "." '{print $1}'`
    test "$OS" = "$OS_VERSION" && { echo_success; echo; } || { echo_failure; echo; exit 1; }
}

### Add version to file sys_tuning.txt
update_sys_tuning()
{
    echo -n "Updating sys_tuning.txt file ..."
    test -f /var/systag/version/sys_tuning.txt || mkdir -p /var/systag/version/
    echo $TAG >> /var/systag/version/sys_tuning.txt && { echo_success; echo; } || { echo_failure; echo; exit 1; }
}

### Backup files
backup_files()
{
    echo -n "Backup files ..."
    backup_dir="/var/systag/backup/$TIME"
    test -d ${backup_dir} || mkdir -p ${backup_dir} || { echo_failure; echo; exit 1; }
	
    cp -p /etc/resolv.conf ${backup_dir}
    cp -p /etc/sysctl.conf ${backup_dir}
    cp -p /etc/security/limits.conf ${backup_dir}
    cp -p /etc/selinux/config ${backup_dir}
    cp -p /etc/security/limits.d/20-nproc.conf ${backup_dir}
    cp -p /etc/ssh/sshd_config ${backup_dir}
    cp -p /etc/profile ${backup_dir}
    cp -p /etc/passwd ${backup_dir}
    cp -p /etc/group ${backup_dir}
    test -f /etc/sysconfig/iptables && cp -p /etc/sysconfig/iptables ${backup_dir}
    test -f /etc/ntp.conf && cp -p /etc/ntp.conf ${backup_dir}
    file_num=`ls -l ${backup_dir} | wc -l`
    test $file_num -ge 9 && { echo_success; echo; } || { echo_failure; echo; exit 1; }
}

# Post-installation verification
post_install_check(){
    echo -n "Reboot verification ..." && { echo_success; echo; } 
    echo -e "${GREEN_COLOR} INFO: 请手工重启服务器，验证操作系统启动是否正常。${RES}" 
}

##### 【基础配置】
### 更新DNS
config_nameserver(){
    echo -n "Updating /etc/resolv.conf ..."
    cat > /etc/resolv.conf << EOF
options timeout:2 attempts:3 rotate single-request-reopen
nameserver 114.114.114.114
nameserver 180.76.76.76
EOF

    grep nameserver /etc/resolv.conf  >/dev/null 2>&1 && { echo_success; echo; } || { echo_failure; echo; exit 1; }
}

### 配置Yum源
config_repos(){
    echo -n "Updating repos ..."
    repo_backup_dir=/etc/yum.repos.d/repo_backup/$TIME
    test -d $repo_backup_dir || mkdir -p $repo_backup_dir
    mv /etc/yum.repos.d/*.repo ${repo_backup_dir}
    # 使用自建镜像仓库
    #wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.51znyx.com/repo/Centos-7.repo >/dev/null 2>&1
    #wget -O /etc/yum.repos.d/epel.repo http://mirrors.51znyx.com/repo/epel-7.repo >/dev/null 2>&1
    
    # 使用中科大镜像仓库(IPTV VTEP服务器使用Aliyun镜像仓库) 
    curl -L $BASE_REPO -o /etc/yum.repos.d/CentOS-Base.repo >/dev/null 2>&1
    curl -L $EPEL_REPO -o /etc/yum.repos.d/epel.repo >/dev/null 2>&1
    sed -i '/aliyuncs.com/d' /etc/yum.repos.d/*.repo
    #sed -i 's/aliyun.com/ustc.edu.cn/' /etc/yum.repos.d/*.repo
	
    yum clean all >/dev/null 2>&1
    yum makecache >> $PROG_LOG
    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; exit 1; }
}

### 关闭selinux
disable_selinux(){
    echo -n "Disabling selinux ..."
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    setenforce 0  >/dev/null 2>&1
    grep 'SELINUX=disabled' /etc/selinux/config >/dev/null 2>&1 && { echo_success; echo; } || { echo_failure; echo; return; }
}

### 关闭防火墙firewalld
disable_firewalld(){
    echo -n "Disabling firewalld ..."
    systemctl disable firewalld.service >/dev/null 2>&1
    systemctl stop firewalld.service
    systemctl list-unit-files firewalld.service | grep disabled  >/dev/null 2>&1 && { echo_success; echo; } || { echo_failure; echo; return; }
}

### 时区配置(GMT+8)
set_time_zone(){
    echo -n "Updating time zone ..."
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && { echo_success; echo; } || { echo_failure; echo; return; }
    rpm -q ntpdate >/dev/null 2>&1 || { yum install -y ntpdate  >> $PROG_LOG; }
    /usr/sbin/ntpdate $NTP_SVC >> $PROG_LOG;

    #echo 'LANG="en_US.UTF-8"' > /etc/locale.conf
} 

### 时间同步
config_ntp(){
    echo -n "Updating NTP ..."
    rpm -q ntp.x86_64 >/dev/null 2>&1 || { yum install -y ntp.x86_64  >> $PROG_LOG; }
    cat > /etc/ntp.conf << EOF
# Ntp Client Configuration.
driftfile  /var/lib/ntp/drift
pidfile   /var/run/ntpd.pid
logfile /var/log/ntp.log

# Access Control Support
restrict    default kod nomodify notrap nopeer noquery
restrict -6 default kod nomodify notrap nopeer noquery
restrict 127.0.0.1

# local clock
server 127.127.1.0
fudge  127.127.1.0 stratum 10

server ntp1.aliyun.com iburst minpoll 4 maxpoll 10
restrict ntp1.aliyun.com nomodify notrap nopeer noquery
server ntp2.aliyun.com iburst minpoll 4 maxpoll 10
restrict ntp2.aliyun.com nomodify notrap nopeer noquery
EOF

    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
    systemctl enable ntpd.service >/dev/null 2>&1
    systemctl disable chronyd >/dev/null 2>&1
    systemctl restart ntpd.service
}

### 关闭不必要的服务
disable_useless_services(){
    echo -n "Disabling useless services ..."
    systemctl stop cups.service  >/dev/null 2>&1
    systemctl disable cups.service  >/dev/null 2>&1
    systemctl stop rpcbind.service >/dev/null 2>&1
    systemctl disable rpcbind.service  >/dev/null 2>&1
    systemctl stop postfix >/dev/null 2>&1
    systemctl disable postfix  >/dev/null 2>&1
    systemctl stop NetworkManager.service >/dev/null 2>&1
    systemctl disable NetworkManager.service  >/dev/null 2>&1
    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
}

### 创建工作帐户
create_user(){
    echo -n "Creating user $WORK_USER ..."
	if grep "$WORK_USER" /etc/passwd 1>/dev/null 2>&1
    then
        echo_failure; echo; 
        echo -e "${YELLOW_COLOR} [WARNING] User $WORK_USER already exists! ${RES}"; echo ""; return;
    else
        grep "$WORK_USER" /etc/group 1>/dev/null 2>&1 || (/usr/sbin/groupadd -g $WORK_GID $WORK_USER)
        [ $? != 0 ] && { echo -e "${YELLOW_COLOR} [WARNING] Creating group $WORK_USER failed! ${RES}"; echo ""; return;}
        grep "$WORK_USER" /etc/passwd 1>/dev/null 2>&1 || (/usr/sbin/useradd -u $WORK_UID -g $WORK_GID -s /bin/bash -c "Working Account" $WORK_USER)
        [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo ""; echo -e "${YELLOW_COLOR} [WARNING] Creating user $WORK_USER failed! ${RES}"; echo; return; }
    fi
}

### 设置命令行级别(init 3)
set_runlevel(){
    echo -n "Setting runlevel ..."
    systemctl get-default >> $PROG_LOG
    systemctl set-default multi-user.target  >/dev/null 2>&1
    systemctl get-default |grep multi-user.target  >/dev/null 2>&1  && { echo_success; echo; } || { echo_failure; echo; return; }
}

### 登陆和欢迎信息
confg_motd(){
    echo -n "Updating motd ..."
    cat > /etc/motd << EOF

All activity will be monitored and reported.

EOF

    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
}

### 设置rc.local开机启动
enable_rclocal(){
    echo -n "Enabling rc.local ..."
    if grep "Install" /usr/lib/systemd/system/rc-local.service 1>/dev/null 2>&1
    then
        echo_failure; echo;
        echo -e "$YELLOW_COLOR [WARNING] rc-local [Install] section already exists! ${RES}"; echo "";
	else
        cat >> /usr/lib/systemd/system/rc-local.service  << EOF

[Install]
WantedBy=multi-user.target
EOF
        [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
    fi

    chmod +x /etc/rc.local
    chmod +x /etc/rc.d/rc.local
    systemctl enable rc-local.service 1>/dev/null 2>&1
}

#####【系统优化】
### 内核参数调整
config_sysctl(){
    echo -n "Updating sysctl.conf ..."
    grep -E 'swappiness|tcp_tw_reuse' /etc/sysctl.conf >/dev/null 2>&1 && { echo_failure; echo; echo -e "${YELLOW_COLOR} WARNING: The sysctl.conf may have been updated by admin. Please check it manually! ${RES}";  echo; return; }
    cat > /etc/sysctl.conf <<EOF
#
# Added by sysadmin for OS optimization
vm.swappiness = 0
net.ipv4.tcp_tw_reuse = 1
#net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.ip_local_port_range = 10240 65000

# Controls the use of TCP syncookies
net.ipv4.tcp_syncookies = 1

# Controls source route verification
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0

# Determines how often to check for stale neighbor entries.
net.ipv4.neigh.default.gc_stale_time=120

# Using arp_announce/arp_ignore to solve the ARP Problem
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.lo.arp_announce=2
net.ipv4.conf.all.arp_announce=2

## Controls the max OS receive/send buffer size for all types of connections.
net.core.rmem_max = 1027840
net.core.wmem_max = 1027840
#net.ipv4.udp_rmem_min = 8388608
#net.ipv4.udp_wmem_min = 8388608
#net.core.netdev_max_backlog = 2000

# Controls the SYN queue size
net.ipv4.tcp_max_syn_backlog = 10240
net.ipv4.tcp_synack_retries = 3

# Controls the maximum number of TIME_WAIT socket
# As server
net.ipv4.tcp_max_tw_buckets = 10000
# As Client
#net.ipv4.tcp_max_tw_buckets = 5000

# Disable IPv6
#net.ipv6.conf.all.disable_ipv6 = 1
#net.ipv6.conf.default.disable_ipv6 = 1
#net.ipv6.conf.lo.disable_ipv6 = 1

# The maximum file handles that can be allocated (also found in /proc/sys/fs/file-max)
fs.file-max = 4096000

# Only for iptables (CONNTRACK_MAX = RAMSIZE (in bytes) / 16384 / (ARCH / 32))
#net.netfilter.nf_conntrack_max = 2097152
#net.ipv4.netfilter.nf_conntrack_tcp_timeout_established = 7200

# Only for Docker host. Fixed issue: "XFS: possible memory allocation deadlock in kmem_alloc"
#vm.min_free_kbytes=524288
EOF

    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }	
    sysctl -p /etc/sysctl.conf  1>/dev/null 2>&1
}

config_limits(){
    echo -n "Updating limits.conf ..."
    if grep -v ^# /etc/security/limits.conf | grep -E "nproc|nofile" 1>/dev/null 2>&1
    then
        echo_failure; echo;
        echo -e "$YELLOW_COLOR [WARNING] The limits.conf may have been updated by admin. Please check it manually!! ${RES}"; echo "";
	else
        sed -i '/# End of file/d' /etc/security/limits.conf
        cat >> /etc/security/limits.conf << EOF
# Added by sysadmin for OS optimization
*           soft   nproc        65536
*           hard   nproc        65536
*           soft   nofile       1024000
*           hard   nofile       1024000

# End of file
EOF
        [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
    fi

    #set max user processes
    sed -i 's/4096/65536/' /etc/security/limits.d/20-nproc.conf
}

#####【安全加固】
### 禁用无效系统用户
disable_useless_user(){
    echo -n "Disabling useless user ..."
    passwd -l adm >/dev/null 2>&1
    passwd -l lp >/dev/null 2>&1
    passwd -l sync >/dev/null 2>&1
    passwd -l games >/dev/null 2>&1
    passwd -l operator >/dev/null 2>&1
    passwd -l dbus >/dev/null 2>&1
    passwd -l ftp >/dev/null 2>&1
    passwd -l mail >/dev/null 2>&1  
    passwd -l shutdown >/dev/null 2>&1
    passwd -l halt >/dev/null 2>&1
    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
}

### SSH优化
config_sshd(){
    echo -n "Updating sshd_config ..."
    sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
    sed -i 's/#ClientAliveInterval 0$/ClientAliveInterval 60/' /etc/ssh/sshd_config
    sed -i 's/^GSSAPIAuthentication yes$/GSSAPIAuthentication no/' /etc/ssh/sshd_config
    sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
    systemctl restart sshd.service
    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
}

config_sudoer(){
    echo -n "Adding user $WORK_USER to wheel group ..."
    if grep "wheel:" /etc/group | grep $WORK_USER  1>/dev/null 2>&1
    then
        echo_failure; echo; 
        echo -e "${YELLOW_COLOR} [WARNING] User $WORK_USER already exists in wheel group! ${RES}"; echo; return;
    else
        usermod -a -G wheel $WORK_USER && { echo_success; echo; } || { echo_failure; echo ""; }
    fi
}

### iptables防火墙设置
iptables_config(){
    echo -n "Updating iptables rules ..."
    rpm -q iptables-services >/dev/null 2>&1 || { yum install -y iptables-services  >> $PROG_LOG; }

    #获取SSH端口
    SSH_PORT="22"
    if grep -v ^# /etc/ssh/sshd_config |grep -i port  1>/dev/null 2>&1
    then 
        SSH_PORT="22,`grep -v ^# /etc/ssh/sshd_config |grep -i port| awk '{print $(NF)}'|tail -1`"
    else
        SSH_PORT="22"
    fi

    #生成iptables规则
    cat > /etc/sysconfig/iptables << EOF
# Firewall configuration written by system-config-securitylevel
# Manual customization of this file is not recommended.
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m multiport --dport ${SSH_PORT} -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 20050 -j ACCEPT
-A INPUT -p icmp -m limit --limit 1/s --limit-burst 10 -j ACCEPT
-A INPUT -f -m limit --limit 100/s --limit-burst 100 -j ACCEPT
-A INPUT -j DROP
#-A INPUT -j REJECT --reject-with icmp-host-prohibited
COMMIT
EOF

    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
    # 根据评审意见，iptables在系统初始化后，由人工验证并确认是否启用。
    systemctl disable iptables.service 1>/dev/null 2>&1
    systemctl stop iptables.service 1>/dev/null 2>&1
	
    echo -e "${GREEN_COLOR} INFO: 请检查Iptables规则，验证并确认后，再手工启动iptables.service。${RES}" 	

}

#####【安装必要工具包】
yum_software(){
    echo -n "Installing packages ..."
    yum install -y vim wget ntpdate sysstat wget \
    man mtr lsof zip perl unzip telnet \
    iotop net-tools openssl-devel \
    openssl-perl iostat nscd \
    gcc gcc-c++ make cmake \
    autoconf bzip2 bzip2-devel curl openssl \
    openssl-devel rsync gd \
    pcre-devel.x86_64 zlib-devel.x86_64 screen.x86_64  nfs-utils.x86_64 pciutils.x86_64 \
    tcpdump.x86_64 iftop.x86_64 htop.x86_64 >> $PROG_LOG
    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
}

### 清除历史记录
erase_history(){
    echo -n "Erasing history log ..."
    #history -c
    echo > /var/log/wtmp
    echo > /var/log/btmp
    [ $? = 0 ] && { echo_success; echo; } || { echo_failure; echo; return; }
}

####################### Main Function #######################
# Source function library.
. /etc/rc.d/init.d/functions

if [ `id -u` -ne 0 ] ; then
  echo -e "$YELLOW_COLOR [WARNING] Please run this script with root. ${RES}"
  exit 1
fi

#####【执行前准备】
color_theme
pre_install_check
backup_files

##### 【基础配置】
config_nameserver
config_repos
disable_selinux
disable_firewalld
set_time_zone
config_ntp
disable_useless_services
create_user
set_runlevel
confg_motd
enable_rclocal

#####【系统优化】
config_sysctl
config_limits

#####【安全加固】
disable_useless_user
config_sshd
config_sudoer
iptables_config

#####【安装必要工具包】
yum_software

#####【执行后工作】
update_sys_tuning
erase_history
post_install_check

### End of File
