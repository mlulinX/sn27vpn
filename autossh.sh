#!/bin/bash

plain='\033[0m'
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


[[ $EUID -ne 0 ]] && echo -e "${red}Error: ${plain} You must use root user to run this script!\n" && exit 1


# Function to check if a pattern exists in a file
file_contains() {
    grep -q "$1" "$2"
}

# Function to replace a pattern with another in a file
replace_in_file() {
    sed -i "s/$1/$2/g" "$3"
}

# Enable Password Authentication in sshd_config
if file_contains "prohibit-password" /etc/ssh/sshd_config; then
    replace_in_file "prohibit-password" "yes" /etc/ssh/sshd_config
fi

if file_contains "without-password" /etc/ssh/sshd_config; then
    replace_in_file "without-password" "yes" /etc/ssh/sshd_config
fi

if file_contains "#PermitRootLogin" /etc/ssh/sshd_config; then
    replace_in_file "#PermitRootLogin" "PermitRootLogin" /etc/ssh/sshd_config
fi

if ! file_contains "PasswordAuthentication" /etc/ssh/sshd_config; then
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
fi

if file_contains "PasswordAuthentication no" /etc/ssh/sshd_config; then
    replace_in_file "PasswordAuthentication no" "PasswordAuthentication yes" /etc/ssh/sshd_config
fi

if file_contains "#PasswordAuthentication no" /etc/ssh/sshd_config; then
    replace_in_file "#PasswordAuthentication no" "PasswordAuthentication yes" /etc/ssh/sshd_config
fi


sed -i 's/#\?Banner .*/Banner \/etc\/ssh\/gcp_skyn/' /etc/ssh/sshd_config 

# Restart the SSH service
service ssh restart > /dev/null

# Prompt to set the root password



echo "$servermessage" | tee /etc/ssh/gcp_skyn >/dev/null



final=$(date "+%Y-%m-%d" -d "+$dias days")
gui=$(date "+%d/%m/%Y" -d "+$dias days")
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -e $final -M -s /bin/false -p $pass $username >/dev/null 2>&1
echo "$password" >/etc/$username >/dev/null 2>&1
echo "$username:$password" | chpasswd
echo "$username $sshlimiter" >>/root/usuarios.db'


echo "Port 2222" >>/etc/ssh/sshd_config
#sed -i "/Port 22/d" /etc/ssh/sshd_config
service ssh restart


echo ""
echo -e "\033[1;32m===================================="
echo -e "\033[1;32m ◼◼◼◼   SN FREENETㅤ ◼◼◼◼  " 
echo -e "\033[1;32m===================================="
echo ""
echo -e "\033[1;37m◈─────⪧ SSH ACCOUNT ⪦─────◈"
echo ""
echo -e "\033[1;32m◈ Host / IP   :⪧  \033[1;31m$IP"
echo -e "\033[1;32m◈ Port        :⪧  \033[1;31m2222 or 22"
echo -e "\033[1;32m◈ Username    :⪧  \033[1;31m$username"
echo -e "\033[1;32m◈ Password    :⪧  \033[1;31m$password"
echo -e "\033[1;32m◈ Login Limit :⪧  \033[1;31m$sshlimiter"
echo -e "\033[1;32m◈ Expire Date :⪧  \033[1;31m$gui"
echo ""
echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ ${plain}"

echo -e "${cyan} Success - ${plain}"
