#!/bin/bash

echo "Checking for open ports on the local machine..."

# Run netstat to get information about open ports
netstat -lntu | awk 'NR > 2 {print $4}' | cut -d: -f2 | sort -n | uniq > open_ports.txt

# Display the open ports
echo -e "\nOpen ports:"
cat open_ports.txt

# Display services running on open ports
#echo -e "\nServices running on open ports:"
while read -r port; do
    service_name=$(lsof -i :$port | awk 'NR > 1 {print $1}')
    echo "Port $port: $service_name"
done < open_ports.txt

echo "Done."


Output:
Blocking access to port 8080 for specified IP addresses: 192.168.1.2 10.0.0.5
iptables v1.8.7 (nf_tables): unknown option "--dport"
Try `iptables -h' or 'iptables --help' for more information.
iptables v1.8.7 (nf_tables): unknown option "--dport"
Try `iptables -h' or 'iptables --help' for more information.
iptables: unrecognized service
Blocking completed. Rules have been applied.
