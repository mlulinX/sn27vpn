servermessage="<h3><font color='red'>
Created by https://t.me/mlulinX
</font></h3>"
sed -i 's/#\?Banner .*/Banner \/etc\/ssh\/snpro/' /etc/ssh/sshd_config
echo "$servermessage" | tee /etc/ssh/snpro >/dev/null
