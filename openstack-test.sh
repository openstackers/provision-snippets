############
# Test set #
############
. ~/keystonerc

function get_id () {
  echo `"$@" | awk '/ id / {print $4}'`
}

# Create external network (floating IPs)
SERVICES_ID=$(get_id keystone tenant-get services)
neutron net-create external --tenant-id $SERVICES_ID --router:external true --shared
neutron subnet-create external 192.168.121.0/24 --tenant-id $SERVICES_ID --disable-dhcp --allocation-pool start=192.168.121.200,end=192.168.121.205 --gateway=192.168.121.1

# Create tenant private network (fixed IPs)
function create_network () {
    CIDR=$1
    NET_ID=$(get_id neutron net-create net1)
    SUBNET_ID=$(get_id neutron subnet-create --name subnet1 ${NET_ID} $CIDR)
    ROUTER_ID=$(get_id neutron router-create router1)
    neutron router-interface-add ${ROUTER_ID} ${SUBNET_ID}
    neutron router-gateway-set ${ROUTER_ID} external
}

create_network  172.16.0.1/24

# Default securitry rules
ADMIN_ID=$(get_id keystone tenant-get admin)
SECURITRY_GROUP=$(neutron security-group-list --tenant-id $ADMIN_ID | awk '/ default / {print $2}')
neutron security-group-rule-create --protocol icmp --direction ingress $SECURITRY_GROUP
neutron security-group-rule-create --protocol tcp --port-range-min 22 --port-range-max 22 --direction ingress $SECURITRY_GROUP

cat > ~/.ssh/id_rsa.pub <<EOD
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCEdSJnk09O9hMMczi+MKRaAkl5mCXBTXo6AuEjujyb8qsCtM4fL6hSaRR3X7XcV5iRztwzUnQ/+ziuh7ySaiiubxe0cFZSoWZreV3NdtNRJW2r2fqnu6MVAoxe4ffzyBUWoegO0KWgxz24nlOA7NrGGNmX+4kCKYWgq+VxVIQ5rVBzbpuViC59WgPHUvWUwFTBoNIEBzwgWUSbZ53+Jxpy2G5sNWDfOqIMjp3SiHxG2BDzw/iQM6Pi9U03r90QJbnuK92Mn+8TXsa7h8M0omDCN4CnU233vLJHxeHgehpZtg75FOkerpU/k7+MCcuIdAgkO7BoXXl+xQElv6uecMT root@aio.os.tst
EOD

cat > ~/.ssh/id_rsa <<EOD
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAwhHUiZ5NPTvYTDHM4vjCkWgJJeZglwU16OgLhI7o8m/KrArT
OHy+oUmkUd1+13FeYkc7cM1J0P/s4roe8kmoorm8XtHBWUqFma3ldzXbTUSVtq9n
6p7ujFQKMXuH388gVFqHoDtCloMc9uJ5TgOzaxhjZl/uJAimFoKvlcVSEOa1Qc26
blYgufVoDx1L1lMBUwaDSBAc8IFlEm2ed/icacthubDVg3zqiDI6d0oh8RtgQ88P
4kDOj4vVNN6/dECW57ivdjJ/vE17Gu4fDNKJgwjeAp1Nt97yyR8Xh4HoaWbYO+RT
pHq6VP5O/jAnLiHQIJDuwaF15fsUBJb+rnnDEwIDAQABAoIBAGmr1cO9e6c8/9C1
SS/JbgBI2rpVUADLaIhSWXsrabIgpwW4uzxFyHMAK0YcSiW7aD4xNS99yJTR1cW6
vIEHFJjOc8BZjGM3TbnZU1nu7GONVcvshLPfKFsmo4pADkMSgDMOPE1GF0LnT40q
0gxlvXsyA2XKFFxwjScyr7Loh4AFfK4grB2+Z/WsVkhE8Q639BTLtj3k0NSgOLzL
M7kv7JKqhe2crN2znS6ZOmBGdHOa96AzT306pW1jrnIxJ+L3ZearbqUQdtFx3RYI
FGmRFzeSiy6Cn7HfkS6H3VvUR6ewNu9A4SxdBWB13/ulY8GEMbQv5YzuayuH/xgH
iWVfoUkCgYEA32WLJZEjiARndutZ2TigkLTczWOVzmpQFyAe3m6PBUJ9EsqWk2YK
FsQrWZz3vlFGimSUxKywNnguYE92Nv05hh0Ck8A3Nl/wKx7eHdfYHccph6y2HKS2
1EycHabvjHDHgwx89sm6gkqe6Ct79VoHsbslxqPDh4pgg8Wj85lVLL8CgYEA3mSV
NWJE+JDoe90oEPXbVvOToB2Lq2TkHGOkG8QzjSJyz9yu0Zq1UMpmyUEab1E9DlJy
qUTx1NUQMfF0xWnTW3FZ4OkAX6pA7cK0xXGhOOqgVoWNrK1hA8b9lBqCtaUa4Hv4
0To73NXjANtf2whK2W5PVMLPHcU3anmn6lPI+q0CgYEA13it2bJAPzVgRkeDBg2k
cW7BeimPmOTaEzQcEhc5Q615zeIxkkJdgM/9sBXCr4LdMycIhxq5bBBHSwXZ0/gy
v7TDg5dmqb+ney/utYI3JaGv4PkpPj9xSRwLiF43t5IgHbqx3ad9iaZH10/55BDO
UxNbwFi8g8NojDDZjmBa0ykCgYAStFL4UnOKlGV5RXiBNKxl+8aGyPVeTPYCjT7Y
NwA+9o7BfMYXSvPE/8D1XExk4GhKNBUAt5O/Wswp5yzzDZuBLV9p0y783MzpMl8R
3CS7LMCfhkwMIeju8GWTd0dXD7Pa/ZJHxqYSRMr633iIa4IgF28Eqf3ReyzV/7Vn
t/RHYQKBgBO3XB6GDhSz2F3OwbSRtzrsj71of/qgIRLEKItW9c9GYBg1XrrQiuoM
aX1bO8OEKkrIkLEMqWMi488JL5iE/0MTmt/qoRMx24WKMNLjTFw0hUj/+BsrWlGX
ryOBqcs+jxSzd6Y9DhbsEhwhSm6BZcDrEDW2v21yzRKr5ELeNO0Z
-----END RSA PRIVATE KEY-----
EOD

chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

nova keypair-add --pub_key ~/.ssh/id_rsa.pub adminkey

glance image-create --name cirros --container-format bare --disk-format qcow2 --is-public 1 --copy-from http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img

sleep 5

NET_ID=$(get_id neutron net-show net1)
nova boot --image cirros --flavor 1 --key_name adminkey --nic net-id=$NET_ID cir1

-------------------------------------
ns=$(ip netns |  awk '/dhcp/ {print $1}')

function get_ip() {
  echo `"$@" | awk '/ network / {print $5}'`
}

IP=$(get_ip nova show f20)
ip netns exec $ns ping -c 10 $IP

