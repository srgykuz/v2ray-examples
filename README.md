# V2Ray Examples

Here I put examples of V2Ray usage. V2Ray means [V2Ray](https://github.com/v2ray/v2ray-core), [V2Fly](https://github.com/v2fly/v2ray-core) or [Xray](https://github.com/XTLS/Xray-core). Examples suit for any, just adapt to the one you using. This project is addition to [v2ray-examples](https://github.com/v2fly/v2ray-examples), [Xray-examples](https://github.com/XTLS/Xray-examples), [v2ray-step-by-step](https://github.com/v2fly/v2ray-step-by-step) and [ToutyRater guide](https://github.com/ToutyRater/v2ray-guide).

## Examples

### [docker](/docker/)

Execute V2Ray using Docker Compose.

### [fallbacks](/fallbacks/)

Pass HTTP and HTTPS traffic from public server to local server. `nginx.conf` should be deployed locally.

### [private-subnet](/private-subnet/)

Access remote private subnet. You should deploy bastion host in a public subnet which runs `server.json`. Bastion host forwards traffic to any address in the private subnet or to specific service in the private subnet.

### [proxylist-bypasslist](/proxylist-bypasslist/)

At client side configure protocols that: proxy all sites, proxy specific sites and bypass all others, bypass specific sites and proxy all others. Quickly switch between these protocols as needed.

### [reverse](/reverse/)

Access client host via SSH using server public IP without enabling V2Ray. Access client LAN hosts via V2Ray using private IP.

### [self-signed-tls](/self-signed-tls/)

Generate self-signed CA and server certificate for use in TLS without enabling `insecure` option. Avoid MITM attack at client side by properly validating TLS.

### [systemd](/systemd/)

Execute V2Ray using systemd. Put: executable in `/usr/local/bin`, config in `/usr/local/etc/v2ray`, log in `/var/log/v2ray`, service as `/etc/systemd/system/v2ray.service`, logrotate as `/etc/logrotate.d/v2ray`. Run as user `nobody`.

### [transparent](/transparent/)

Run V2Ray as transparent proxy to intercept all traffic. For example you can run it on Raspberry Pi and set it as default gateway for router to transparently proxy all LAN devices. Replace `192.168.0.1` with router IP, replace `192.168.0.102` with client IP, replace `192.168.0.0/16` with LAN subnet.

### [tunnel](/tunnel/)

Access private host from public internet or turn this host into proxy. Run `bridge.jsonc` at the private host and run `portal.jsonc` at a public VPS. Traffic flows this way: client -> VPS (portal) -> private host (bridge) -> internet.
