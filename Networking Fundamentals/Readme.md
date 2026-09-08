# Command Practice

## 1. Local Host and interface configuration
- `ip a`: Displays all network interfaces, their link states (UP/DOWN), MAC addresses, and assigned IP addresses.
![ip a](<screenshots/ip-a.png>)

- `arp`: Shows the local ARP cache that maps neighboring IPv4 addresses to physical MAC hardware addresses.
![arp](<screenshots/arp.png>)

- `systemctl`: Checks the status of system services to ensure network-related daemons are running properly.
![systemctl](<screenshots/systemctl.png>)

## 2. Gateway & Routing
- `ip route`: Displays the kernel's routing table to show which gateway traffic uses to reach other networks.
![ip route](<screenshots/ip-route.png>)

## 3. Connectivity & Path Diagnostics
- `ping`: Tests basic Layer 3 connectivity to a remote host using ICMP echo requests and measures latency.
![ping](<screenshots/ping.png>)

- `traceroute`: Traces the exact hop-by-hop router path packets take to reach a destination by incrementing the TTL.
![traceroute](<screenshots/traceroute.png>)

## 4. DNS Resolution
- `nslookup`: A simple query tool used to verify that a domain name resolves to an IP address via DNS.
![nslookup](<screenshots/nslookup.png>)

- `dig`: An advanced DNS lookup utility that returns detailed query records, server responses, and TTL information.
![dig](<screenshots/dig>)

## 5. Port & Socket Inspection
- `ss/netstat`: Lists all active network connections and identifies which processes are listening on local TCP/UDP ports.
![ss/netstat](<screenshots/ss-netstat.png>)

- `nc (netcat)`: Scans and verifies whether a specific remote TCP or UDP port is open and accepting traffic.
![netcat](<screenshots/netcat.png>)

- `telnet`: Tests if a connection can be established to a remote service on a specific TCP port.
![telnet](<screenshots/telnet.png>)

## 6. Application Layer & HTTP Requests
- `curl`: Sends HTTP/HTTPS requests to an endpoint and inspects status codes, response headers, and payloads.
![curl](<screenshots/curl.png>)

- `wget`: Downloads files or web content non-interactively directly from a remote URL over HTTP/HTTPS/FTP.
![wget](<screenshots/wget.png>)

## 7. Deep Packet Analysis
- `tcpdump`: Captures, decodes, and inspects raw network packets moving across an interface in real time.
![tcpdump](<screenshots/tcpdump.png>)