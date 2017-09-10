### Install the vagrant plugin
```
vagrant plugin install vagrant-vbguest
```

### Current Nodes

|Vagrant Node|IP||
|:---|:----:|:----|
|Docker|192.168.0.10|vagrant up docker|
|RabbitMQ|192.168.0.11|vagrant up rabbitmq|
|Tomcat-8|192.168.0.12|vagrant up tomcat8|
|MySQL|192.168.0.13|vagrant up mysql|
|HAProxy|192.168.0.14|vagrant up loadbalancer|
|Apache|192.168.0.15|vagrant up web1|
|Apache|192.168.0.16|vagrant up web2|
|Consul|192.168.0.17|vagrant up consulserver|


### Consul
to run the server node (leader)
```
consul agent -server -bootstrap -advertise 192.168.0.17 -data-dir /tmp/consul
```
to run the consul client in 192.168.0.15
```
consul agent -client 192.168.0.15 -config-file  config.file.json
```
where the config.file.json is
```json
{
  "ui":true,
  "retry_join":["192.168.0.17"],
  "advertise_addr":"192.168.0.15",
  "data_dir":"/tmp/consul"
}
```
To see the consul web ui
```
http://192.168.0.15:8500/ui
```
