echo "Snippet - keystonerc V2"
password=$1
token=$2
public=$3
version=$4 # '/v2.0'

cat > /root/keystonerc <<EOD
export ADMIN_TOKEN=$token
export OS_USERNAME=admin
export OS_TENANT_NAME=admin
export OS_PASSWORD=$password
export OS_AUTH_URL=http://${public}:5000${version}/
export OS_REGION_NAME=RegionOne
export PS1="[\u@\h \W(keystone_admin)]$ "
EOD
