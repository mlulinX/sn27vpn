#!/bin/bash

plain='\033[0m'

#စာလုံးအရောင်များ(Server Message)
red='\e[31m'    #အနီရောင်
yellow='\e[33m' #အဝါရောင်
gray='\e[90m'   #မီးခိုးရောင်
green='\e[92m'  #အစိမ်းရောင်
blue='\e[94m'   #အပြာရောင်
magenta='\e[95m'#ပန်းခရမ်းရောင်
cyan='\e[96m'   #စိမ်းပြာရောင်
none='\e[0m'    #အရောင်မရှိ

username="snxsn"
password="snxsn"
sshlimiter="1000"
dias="2"


servermessage="<h3><font color='red'>
Created by Skyn®SN | https://t.me/mlulinX
</font></h3>"

#apt-get update && apt-get upgrade -n && apt-get install openssh-server && apt-get install openssh-client

[[ $EUID -ne 0 ]] && echo -e "${red}Error: ${plain} You must use root user to run this script!\n" && exit 1

sed -i 's/#\?AllowTcpForwarding .*/AllowTcpForwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?X11Forwarding .*/X11Forwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config && sed -i 's/#\?PermitEmptyPasswords .*/PermitEmptyPasswords no/' /etc/ssh/sshd_config && sed -i 's/#\?Banner .*/Banner \/etc\/ssh\/gcp_skyn/' /etc/ssh/sshd_config && sed -i 's/#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config  && sed -i 's/#\?UseDNS .*/UseDNS no/' /etc/ssh/sshd_config && sed -i 's/#\?Compression .*/Compression delayed/' /etc/ssh/sshd_config && sed -i 's/#\?ForwardX11Trusted .*/ForwardX11Trusted yes/' /etc/ssh/sshd_config &&  sed -i 's/#\?ServerAliveInterval .*/ServerAliveInterval 120/' /etc/ssh/sshd_config && /etc/init.d/ssh restart;

echo "$servermessage" | tee /etc/ssh/gcp_skyn >/dev/null
final=$(date "+%Y-%m-%d" -d "+$dias days")
gui=$(date "+%d/%m/%Y" -d "+$dias days")
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -e $final -M -s /bin/false -p $pass $username >/dev/null
echo "$password" >/etc/$username
echo "$username:$password" | chpasswd
echo "$username $sshlimiter" >>/root/usuarios.db


IP=$(wget -qO- ipv4.icanhazip.com)

fun_bar() {
	comando[0]="$1"
	comando[1]="$2"
	(
		[[ -e $HOME/fim ]] && rm $HOME/fim
		${comando[0]} -y >/dev/null 2>&1
		${comando[1]} -y >/dev/null 2>&1
		touch $HOME/fim
	) >/dev/null 2>&1 &
}


echo ""

echo -e "\033[1;31m◇─────────────SN OPTIMIZATION───────────◇\033[0m"
echo ""

fun_limpram() {
	sync
	echo 3 >/proc/sys/vm/drop_caches
	sync && sysctl -w vm.drop_caches=3
	sysctl -w vm.drop_caches=0
	swapoff -a
	swapon -a
	sleep 4
}
function aguarde() {
	sleep 1
	helice() {
		fun_limpram >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m◇ CLEANING MEMORY \033[1;32m◇ RAM \033[1;37me \033[1;32m◇ CACHE\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DOk"
}
aguarde
sleep 1
clear

sed -i "/Port 990" /etc/ssh/sshd_config >/dev/null 2>&1

/etc/init.d/ssh restart

sleep 2



echo ""

echo ""
echo -e "\033[1;32m===================================="
echo -e "\033[1;32m   ❖  SN FREENETㅤ ❖  " 
echo -e "\033[1;32m===================================="
echo ""
echo -e "\033[1;37m◈─────⪧ SSH ACCOUNT ⪦─────◈"
echo ""
echo -e "\033[1;32m◈ Host / IP   :⪧  \033[1;31m$IP"
echo -e "\033[1;32m◈ Port        :⪧  \033[1;31m990"
echo -e "\033[1;32m◈ Username    :⪧  \033[1;31m$username"
echo -e "\033[1;32m◈ Password    :⪧  \033[1;31m$password"
echo -e "\033[1;32m◈ Login Limit :⪧  \033[1;31m$sshlimiter"
echo -e "\033[1;32m◈ Expire Date :⪧  \033[1;31m$gui"
echo ""
echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ ${plain}"

echo -e "${cyan} Success - ${plain}"
