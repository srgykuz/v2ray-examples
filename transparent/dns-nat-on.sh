iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to-destination 192.168.0.1
iptables -t nat -A PREROUTING -p tcp --dport 53 -j DNAT --to-destination 192.168.0.1

iptables -t nat -A POSTROUTING -p udp --dport 53 -j SNAT --to-source 192.168.0.102
iptables -t nat -A POSTROUTING -p tcp --dport 53 -j SNAT --to-source 192.168.0.102
