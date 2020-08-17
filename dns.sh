sudo apt install -y dnsmasq
echo 'server=/consul/127.0.0.1#8600 
no-poll 
server=8.8.8.8 
local-service' | sudo tee /etc/dnsmasq.conf 
echo 'domain c.ngp-intern-platform.internal
search c.ngp-intern-platform.internal. google.internal.
nameserver 127.0.0.1
nameserver 169.254.169.254' | sudo tee /etc/resolv.conf
sudo systemctl restart dnsmasq
