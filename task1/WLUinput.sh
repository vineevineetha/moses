
#!/bin/bash

input=

while [ "$input" != "quit" ]; do

   read -p "Enter something (type 'quit' to exit): " input

   echo "You entered: $input"

done
