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

username="iiii"
password="iiii"
sshlimiter="1000"
dias="2"


servermessage="
<h4 style=\"text-align:center\"><font color=\"magenta\"> Success </font></h4> "

apt-get update && apt install dos2unix -y && apt install net-tools -y && apt install netstat -y && apt install bc -y

[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
clear

[[ $EUID -ne 0 ]] && echo -e "${red}Error: ${plain} You must use root user to run this script!\n" && exit 1

sed -i 's/#\?AllowTcpForwarding .*/AllowTcpForwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?X11Forwarding .*/X11Forwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config && sed -i 's/#\?PermitEmptyPasswords .*/PermitEmptyPasswords no/' /etc/ssh/sshd_config && sed -i 's/#\?Banner .*/Banner \/etc\/ssh\/gcp_skyn/' /etc/ssh/sshd_config && sed -i 's/#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config  && sed -i 's/#\?UseDNS .*/UseDNS no/' /etc/ssh/sshd_config && sed -i 's/#\?Compression .*/Compression delayed/' /etc/ssh/sshd_config && sed -i 's/#\?ForwardX11Trusted .*/ForwardX11Trusted yes/' /etc/ssh/sshd_config &&  sed -i 's/#\?ServerAliveInterval .*/ServerAliveInterval 120/' /etc/ssh/sshd_config && /etc/init.d/ssh restart;

sed -i 's/#\?Port .*/Port 2222/g' /etc/ssh/sshd_config >/dev/null && sed -i 's/#\?Protocol .*/Protocol 2/g' /etc/ssh/sshd_config >/dev/null && service ssh restart

echo "$servermessage" | tee /etc/ssh/gcp_skyn >/dev/null
final=$(date "+%Y-%m-%d" -d "+$dias days")
gui=$(date "+%d/%m/%Y" -d "+$dias days")
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -e $final -M -s /bin/false -p $pass $username >/dev/null
echo "$password" >/etc/$username
echo "$username:$password" | chpasswd
echo "$username $sshlimiter" >>/root/usuarios.db


IP=$(wget -qO- ipv4.icanhazip.com)
echo ""

echo ""
echo -e "\033[1;32m===================================="
echo -e "\033[1;32m   ❖  SN FREENETㅤ ❖  " 
echo -e "\033[1;32m===================================="
echo ""
echo -e "\033[1;37m◈─────⪧ SSH ACCOUNT ⪦─────◈"
echo ""
echo -e "\033[1;32m◈ Host / IP   :⪧  \033[1;31m$IP"
echo -e "\033[1;32m◈ Port        :⪧  \033[1;31m2222"
echo -e "\033[1;32m◈ Username    :⪧  \033[1;31m$username"
echo -e "\033[1;32m◈ Password    :⪧  \033[1;31m$password"
echo -e "\033[1;32m◈ Login Limit :⪧  \033[1;31m$sshlimiter"
echo -e "\033[1;32m◈ Expire Date :⪧  \033[1;31m$gui"
echo ""
echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ ${plain}"

echo -e "${cyan} Success - ${plain}"
