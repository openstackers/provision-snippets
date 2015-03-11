echo "Snippet - Selinux off"

setenforce 0

cat > /etc/selinux/config << EOD
SELINUX=disabled
SELINUXTYPE=targeted 
EOD
