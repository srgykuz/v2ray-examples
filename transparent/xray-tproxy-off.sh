ip rule del fwmark 1 table 100
ip route del local 0.0.0.0/0 dev lo table 100

iptables -t mangle -D PREROUTING 1
iptables -t mangle -D PREROUTING 1
iptables -t mangle -D PREROUTING 1

iptables -t mangle -D OUTPUT 1
iptables -t mangle -D OUTPUT 1

iptables -t mangle -F XRAY_DIVERT
iptables -t mangle -X XRAY_DIVERT

iptables -t mangle -F XRAY_DIRECT
iptables -t mangle -X XRAY_DIRECT

iptables -t mangle -F XRAY_IN
iptables -t mangle -X XRAY_IN

iptables -t mangle -F XRAY_OUT
iptables -t mangle -X XRAY_OUT
