# Reset the firewall
iptables -P INPUT   ACCEPT
iptables -P OUTPUT  ACCEPT
iptables -P FORWARD ACCEPT
iptables -F
iptables -X

# Set policy
iptables -P INPUT   DROP
iptables -P OUTPUT  DROP
iptables -P FORWARD DROP

# Drop everything invalid
iptables -A INPUT -m state --state INVALID -j DROP

# Config ssh for vagrant and loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT  -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISH,RELATED -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 22 -m conntrack --ctstate ESTABLISH,RELATED -j ACCEPT
iptables -A INPUT  -p tcp -m tcp --sport 22 -m conntrack --ctstate ESTABLISH,RELATED -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISH,RELATED -j ACCEPT

# Config INPUT for HTTP server
iptables -A INPUT -p tcp --sport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp -m tcp --sport 80 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp -m tcp --sport 443 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -j LOG --log-prefix "DROPPED:"

# Config OUTPUT for HTTP access
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 80 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 
iptables -A OUTPUT -p tcp -m tcp --sport 443 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 
iptables -A OUTPUT -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

# Config NAT
sysctl net.ipv4.ip_forward=1 >> /dev/null
iptables -t nat -A POSTROUTING -o enp0s9 -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i enp0s8 -o enp0s9 -j ACCEPT


iptables -A PREROUTING -t nat -i enp0s8 -p tcp --dport 80 -j DNAT --to 192.168.0.10:80
iptables -A FORWARD -p tcp -d 192.168.0.10 --dport 80 -j ACCEPT

iptables -A PREROUTING -t nat -i enp0s8 -p tcp --dport 80 -j DNAT --to 192.168.0.10:80
iptables -A FORWARD -p tcp -d 192.168.0.10 --dport 80 -j ACCEPT

iptables -A PREROUTING -t nat -i enp0s8 -p tcp --dport 443 -j DNAT --to 192.168.0.10:80
iptables -A FORWARD -p tcp -d 192.168.0.10 --dport 443 -j ACCEPT

iptables -A PREROUTING -t nat -i enp0s8 -p tcp --dport 5432 -j DNAT --to 192.168.0.30:5432
iptables -A FORWARD -p tcp -d 192.168.0.30 --dport 5432 -j ACCEPT


#correr este script en app


#revisar que funcione ssh a app  / pidio key pero si
#curl google desde router(app) / si
#curl  desde router(app) a serv apache 192.168.0.10:80/ si
#host - curl a router - tiene que contestar apache NEIN

#cambiar ip publica y privada de segmento y checar a donde se estan conectando -  >.<  
