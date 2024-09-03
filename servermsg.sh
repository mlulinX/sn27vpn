red='\e[31m'    #အနီရောင်
yellow='\e[33m' #အဝါရောင်
gray='\e[90m'   #မီးခိုးရောင်
green='\e[92m'  #အစိမ်းရောင်
blue='\e[94m'   #အပြာရောင်
magenta='\e[95m'#ပန်းခရမ်းရောင်
cyan='\e[96m'   #စိမ်းပြာရောင်
none='\e[0m'    #အရောင်မရှိ


apt-get update



servermessage="<h2><font color='red'>Telegram: https://t.me/mlulinX</font></h2>
<font color="#F5FE00"><b> ꔷꔷꔷ ✿ Powered by SN ✿ ꔷꔷꔷ</b></font><br>
"
sed -i 's/#\?Banner .*/Banner \/etc\/ssh\/snpro/' /etc/ssh/sshd_config
echo "$servermessage" | tee /etc/ssh/snpro >/dev/null
