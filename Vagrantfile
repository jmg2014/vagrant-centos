# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|


  config.vm.box = "centos/7"
  config.vm.provision "shell", path: "provision/node.sh", privileged: true

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "1024"
    vb.cpus = 1
   end

   # docker node
   config.vm.define "docker" do |docker|
		docker.vm.hostname="docker-01"
		docker.vm.network "public_network", ip: "192.168.0.10"
    docker.vm.provision "shell", path: "provision/node-docker.sh", privileged: true
		#web.vm.provision :"shell", inline: 'echo $path > /home/vagrant/.ssh/authorized_keys'
   end

   # rabbitmq node
   config.vm.define "rabbitmq" do |rabbitmq|
		rabbitmq.vm.hostname="rabbitmq-01"
		rabbitmq.vm.network "public_network", ip: "192.168.0.11"
    rabbitmq.vm.provision "shell", path: "provision/node-rabbitmq.sh", privileged: true
		#web.vm.provision :"shell", inline: 'echo $path > /home/vagrant/.ssh/authorized_keys'
   end

   # tomcat8
   config.vm.define "tomcat8" do |tomcat8|
		tomcat8.vm.synced_folder "provision/files/tomcat8", "/opt/vagrant" ,nfs: true
		tomcat8.vm.hostname="tomcat8-01"
		tomcat8.vm.network "public_network", ip: "192.168.0.12"
    tomcat8.vm.provision "shell", path: "provision/node-tomcat8.sh", privileged: true
   end

   # mysql
     config.vm.define "mysql" do |mysql|
       mysql.vm.synced_folder "provision/files/database", "/opt/vagrant/database" ,nfs: true
       mysql.vm.hostname="mysql-01"
       mysql.vm.network "private_network", ip: "192.168.0.13"
       mysql.vm.network "forwarded_port", guest: 3306, host: 3308
       mysql.vm.provision "shell", path: "provision/node-mysql.sh", privileged: true
       mysql.vm.provider :virtualbox do |vb|
         vb.customize ["modifyvm", :id, "--memory", "2048"]
         vb.customize ["modifyvm", :id, "--cpus", "2"]
       end
     end

     # loadbalancer - consul
     config.vm.define "loadbalancer" do |loadbalancer_config|
      #loadbalancer_config.vm.network :forwarded_port, guest: 8080, host: 8080
      #loadbalancer_config.vm.network :forwarded_port, guest: 80, host: 8081
  		loadbalancer_config.vm.hostname="loadbalancer-01"
  		loadbalancer_config.vm.network "public_network", ip: "192.168.0.14"
      loadbalancer_config.vm.provision "shell", path: "provision/node-loadbalancer.sh", privileged: true
     end

     #web 1
     config.vm.define :web1 do |web1|
       web1.vm.hostname="web-01"
       web1.vm.network "public_network", ip: "192.168.0.15"
       web1.vm.provision "shell", path: "provision/node-web.sh", privileged: true
      end

      #web 2
      config.vm.define :web2 do |web2|
        web2.vm.hostname="web-02"
        web2.vm.network "public_network", ip: "192.168.0.16"
        web2.vm.provision "shell", path: "provision/node-web.sh", privileged: true
      end

      #consul server
      config.vm.define :consulserver do |consulserver|
        consulserver.vm.hostname="consul-01"
        consulserver.vm.network "public_network", ip: "192.168.0.17"
        consulserver.vm.provision "shell", path: "provision/consul.sh", privileged: true
      end




end
