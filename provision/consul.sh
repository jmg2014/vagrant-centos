# Consul installation

# Install unzip
yum install unzip -y

# Download consul
CONSUL_VERSION=0.9.3
curl https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip

# Install consul
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul

# Create config directory
sudo mkdir /etc/consul.d
sudo chmod a+w /etc/consul.d

sudo firewall-cmd --zone=public --permanent --add-port=8300/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8301/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8500/tcp
sudo service firewalld restart
