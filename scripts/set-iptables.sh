#!/usr/bin/env sh

#iptables -F
#iptables -F -t nat
#iptables -A INPUT -i lo -j ACCEPT
#iptables -A INPUT -i eth0 -p tcp -m multiport --dports 22,80,9091 -m state --state NEW,ESTABLISHED -j ACCEPT

# transmission control
iptables -t nat -I PREROUTING 1 -p tcp --dport 9091 -j DNAT --to 10.0.3.77:9091
iptables -I INPUT 1 -i eth0 -p tcp --dport 9091 -m state --state NEW,ESTABLISHED -j ACCEPT


# webserver
iptables -t nat -I PREROUTING 1 -p tcp --dport 8080 -j DNAT --to 10.0.3.150:80
iptables -I INPUT 1 -i eth0 -p tcp --dport 8080 -m state --state NEW,ESTABLISHED -j ACCEPT

