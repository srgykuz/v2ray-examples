ip rule add fwmark 1 table 100
ip route add local 0.0.0.0/0 dev lo table 100

iptables -t mangle -N XRAY_DIVERT
iptables -t mangle -A XRAY_DIVERT -j MARK --set-mark 1
iptables -t mangle -A XRAY_DIVERT -j ACCEPT
iptables -t mangle -A PREROUTING -p tcp -m socket -j XRAY_DIVERT

iptables -t mangle -N XRAY_DIRECT
iptables -t mangle -A XRAY_DIRECT -p tcp -d 192.168.0.0/16 ! --dport 53 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -p udp -d 192.168.0.0/16 ! --dport 53 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -m mark --mark 255 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 0.0.0.0/8 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 10.0.0.0/8 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 100.64.0.0/10 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 127.0.0.0/8 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 169.254.0.0/16 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 172.16.0.0/12 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 192.0.0.0/24 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 198.18.0.0/15 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 224.0.0.0/4 -j ACCEPT
iptables -t mangle -A XRAY_DIRECT -d 255.255.255.255/32 -j ACCEPT
iptables -t mangle -A PREROUTING -j XRAY_DIRECT
iptables -t mangle -A OUTPUT -j XRAY_DIRECT

iptables -t mangle -N XRAY_IN
iptables -t mangle -A XRAY_IN -p tcp -j TPROXY --on-ip 127.0.0.1 --on-port 2000 --tproxy-mark 1
iptables -t mangle -A XRAY_IN -p udp -j TPROXY --on-ip 127.0.0.1 --on-port 2000 --tproxy-mark 1
iptables -t mangle -A PREROUTING -j XRAY_IN

iptables -t mangle -N XRAY_OUT
iptables -t mangle -A XRAY_OUT -p tcp -j MARK --set-mark 1
iptables -t mangle -A XRAY_OUT -p udp -j MARK --set-mark 1
iptables -t mangle -A OUTPUT -j XRAY_OUT
