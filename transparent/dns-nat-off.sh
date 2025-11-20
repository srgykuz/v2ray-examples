iptables -t nat -D PREROUTING -p udp --dport 53 -j DNAT --to-destination 192.168.0.1
iptables -t nat -D PREROUTING -p tcp --dport 53 -j DNAT --to-destination 192.168.0.1

iptables -t nat -D POSTROUTING -p udp --dport 53 -j SNAT --to-source 192.168.0.102
iptables -t nat -D POSTROUTING -p tcp --dport 53 -j SNAT --to-source 192.168.0.102
