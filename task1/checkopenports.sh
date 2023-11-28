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

