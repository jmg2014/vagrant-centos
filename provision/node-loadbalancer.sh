#!/usr/bin/env bash

###### HAProxy installation

# Install haproxy
  yum install haproxy -y

  # Configure haproxy
  cat > /etc/default/haproxy <<EOD
# Set ENABLED to 1 if you want the init script to start haproxy.
ENABLED=1
# Add extra flags here.
#EXTRAOPTS="-de -m 16"
EOD
  cat > /etc/haproxy/haproxy.cfg <<EOD
global
    daemon
    maxconn 256
defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend http-in
        bind *:80
        acl  has_special_uri path_beg /first-blog
        use_backend special_server if has_special_uri
        default_backend webservers

backend webservers
        balance roundrobin
        # Poor-man's sticky
        # balance source
        # JSP SessionID Sticky
        # appsession JSESSIONID len 52 timeout 3h
        option httpchk
        option forwardfor
        option http-server-close
        server my-server-01 192.168.0.15:80 maxconn 32 check


backend special_server
       balance roundrobin
       option forwardfor
       server my-server-02 192.168.0.16:80 maxconn 32 check

listen admin
    bind *:8080
    stats enable
EOD

sudo service haproxy start

sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8081/tcp
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo service firewalld restart

# http://192.168.0.14:8080/haproxy?stats   To see the stats
