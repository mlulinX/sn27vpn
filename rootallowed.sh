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


apt-get update && apt install dos2unix -y && apt install net-tools -y && apt install netstat -y && apt install bc -y

[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
clear

[[ $EUID -ne 0 ]] && echo -e "${red}Error: ${plain} You must use root user to run this script!\n" && exit 1

sed -i 's/#\?AllowTcpForwarding .*/AllowTcpForwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?X11Forwarding .*/X11Forwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config && sed -i 's/#\?PermitEmptyPasswords .*/PermitEmptyPasswords no/' /etc/ssh/sshd_config && sed -i 's/#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config  && sed -i 's/#\?UseDNS .*/UseDNS no/' /etc/ssh/sshd_config && sed -i 's/#\?Compression .*/Compression delayed/' /etc/ssh/sshd_config && sed -i 's/#\?ForwardX11Trusted .*/ForwardX11Trusted yes/' /etc/ssh/sshd_config &&  sed -i 's/#\?ServerAliveInterval .*/ServerAliveInterval 120/' /etc/ssh/sshd_config && /etc/init.d/ssh restart;


echo -e "\033[1;32m===================================="
echo -e "\033[1;32m   ❖  SN FREENETㅤ ❖  " 
echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ ${plain}"

echo -e "${cyan} Success - ${plain}"
