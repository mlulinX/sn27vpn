red='\e[31m'    #အနီရောင်
yellow='\e[33m' #အဝါရောင်
gray='\e[90m'   #မီးခိုးရောင်
green='\e[92m'  #အစိမ်းရောင်
blue='\e[94m'   #အပြာရောင်
magenta='\e[95m'#ပန်းခရမ်းရောင်
cyan='\e[96m'   #စိမ်းပြာရောင်
none='\e[0m'    #အရောင်မရှိ


apt-get update



servermessage="<h3><font color='red'>
🇲🇲 🇲🇲 Powered by SN
Telegram: https://t.me/mlulinX
</font></h3>"
sed -i 's/#\?Banner .*/Banner \/etc\/ssh\/snpro/' /etc/ssh/sshd_config
echo "$servermessage" | tee /etc/ssh/snpro >/dev/null
