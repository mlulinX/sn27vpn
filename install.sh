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
sshlimiter="600"
dias="2"
servermessage="<h3><font color='red'>
Created by Skyn®SN (@mlulinX)
</font></h3>"

apt update && apt-get install openssh-server

ulimit -n 51200 && sysctl -p

[[ $EUID -ne 0 ]] && echo -e "${red}Error: ${plain} You must use root user to run this script!\n" && exit 1


sed -i 's/#\?AllowTcpForwarding .*/AllowTcpForwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?X11Forwarding .*/X11Forwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config && sed -i 's/#\?PermitEmptyPasswords .*/PermitEmptyPasswords no/' /etc/ssh/sshd_config && sed -i 's/#\?Banner .*/Banner \/etc\/ssh\/gcp_skyn/' /etc/ssh/sshd_config && sed -i 's/#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config  && sed -i 's/#\?UseDNS .*/UseDNS no/' /etc/ssh/sshd_config && sed -i 's/#\?Compression .*/Compression delayed/' /etc/ssh/sshd_config && sed -i 's/#\?ForwardX11Trusted .*/ForwardX11Trusted yes/' /etc/ssh/sshd_config &&  sed -i 's/#\?ServerAliveInterval .*/ServerAliveInterval 180/' /etc/ssh/sshd_config && /etc/init.d/ssh restart;


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
	tput civis
	echo -ne "     \033[1;33m◇ Please Wait... \033[1;37m- \033[1;33m["
	while true; do
		for ((i = 0; i < 18; i++)); do
			echo -ne "\033[1;31m#"
			sleep 0.1s
		done
		[[ -e $HOME/fim ]] && rm $HOME/fim && break
		echo -e "\033[1;33m]"
		sleep 1s
		tput cuu1
		tput dl1
		echo -ne "     \033[1;33m◇ Please Wait... \033[1;37m- \033[1;33m["
	done
	echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
	tput cnorm
}
[[ $(grep -wc mlocate /var/lib/dpkg/statoverride) != '0' ]] && sed -i '/mlocate/d' /var/lib/dpkg/statoverride
clear
echo -e "\E[44;1;37m                🐉ㅤServer Optimizeㅤ🐉                \E[0m"
echo ""
echo -e "\033[1;32m             ◇ Updating packages\033[0m"
echo ""
fun_bar 'apt-get update -y' 'apt-get upgrade -y'
echo ""
echo -e "\033[1;32m    ◇ Fixing dependency issues"
echo""
fun_bar 'apt-get -f install'
echo""
echo -e "\033[1;32m          ◇ Removing useless packages"
echo ""
fun_bar 'apt-get autoremove -y' 'apt-get autoclean -y'
echo ""
echo -e "\033[1;32m      ◇  Removing problem packages"
echo ""
fun_bar 'apt-get -f remove -y' 'apt-get clean -y'
#Limpar o cache memoria RAM
clear
echo -e "\033[1;31m◇────────────────────────────────────────────────◇\033[0m"
echo ""
MEM1=$(free | awk '/Mem:/ {print int(100*$3/$2)}')
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
swap1=$(free -h | grep -i swap | awk {'print $2'})
swap2=$(free -h | grep -i swap | awk {'print $4'})
swap3=$(free -h | grep -i swap | awk {'print $3'})
echo -e "\033[1;31m•\033[1;32m◇ Before\033[1;31m•\033[0m                    \033[1;31m•\033[1;32m◇ After\033[1;31m•\033[0m"
echo -e " \033[1;33m◇ Total RAM: \033[1;37m$ram1                   \033[1;33m◇ Total RAM: \033[1;37m$swap1"
echo -e " \033[1;33m◇ In use: \033[1;37m$ram3                  \033[1;33m◇ In use: \033[1;37m$swap3"
echo -e " \033[1;33m◇ Free: \033[1;37m$ram2                   \033[1;33m◇ Free: \033[1;37m$swap2\033[0m"
echo ""
echo -e "\033[1;37m◇ Memory \033[1;32m◇ RAM \033[1;37m◇ Before Optimization:\033[1;36m" $MEM1%
echo ""
echo -e "\033[1;31m◇────────────────────────────────────────────────◇\033[0m"
sleep 2
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
	echo -ne "\033[1;37m◇ CLEANING MEMORY \033[1;32m◇ RAM \033[1;37me \033[1;32m◇ SWAP\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DOk"
}
aguarde
sleep 1
clear
echo -e "\033[1;32m◇────────────────────────────────────────────────◇\033[0m"
echo ""
MEM2=$(free | awk '/Mem:/ {print int(100*$3/$2)}')
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
swap1=$(free -h | grep -i swap | awk {'print $2'})
swap2=$(free -h | grep -i swap | awk {'print $4'})
swap3=$(free -h | grep -i swap | awk {'print $3'})
echo -e "\033[1;31m•\033[1;32m◇ Before\033[1;31m•\033[0m                    \033[1;31m•\033[1;32m◇ After\033[1;31m•\033[0m"
echo -e " \033[1;33m◇ Total RAM: \033[1;37m$ram1                   \033[1;33m◇ Total RAM: \033[1;37m$swap1"
echo -e " \033[1;33m◇ In Use: \033[1;37m$ram3                  \033[1;33m◇ In use: \033[1;37m$swap3"
echo -e " \033[1;33m◇ Free: \033[1;37m$ram2                   \033[1;33m◇ Free: \033[1;37m$swap2\033[0m"
echo ""
echo -e "\033[1;37m◇ Memory \033[1;32mRAM \033[1;37m◇ Optimized percentage:\033[1;36m" $MEM2%
echo ""
echo -e "\033[1;37m◇ Saving :\033[1;31m $(expr $MEM1 - $MEM2)%\033[0m"
echo ""
echo -e "\033[1;32m◇────────────────────────────────────────────────◇\033[0m"






echo ""
echo -e "\033[1;32m===================================="
echo -e "\033[1;32m   🇲🇲 SN FREENETㅤ 🇲🇲  " 
echo -e "\033[1;32m===================================="
echo ""
echo -e "\033[1;37m◈─────⪧ SSH ACCOUNT ⪦─────◈"
echo ""
echo -e "\033[1;32m◈ Host / IP   :⪧  \033[1;31m$IP"
echo -e "\033[1;32m◈ Port        :⪧  \033[1;31m22"
echo -e "\033[1;32m◈ Username    :⪧  \033[1;31m$username"
echo -e "\033[1;32m◈ Password    :⪧  \033[1;31m$password"
echo -e "\033[1;32m◈ Login Limit :⪧  \033[1;31m$sshlimiter"
echo -e "\033[1;32m◈ Expire Date :⪧  \033[1;31m$gui"
echo ""
echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ ${plain}"

echo -e "${cyan} Success - ${plain}"
