#!usr/bin/bash
echo "======= SCANNING LOCAL IP ========"

OCTETS=$(ifconfig | grep "broadcast" | cut -d " " -f 2 | cut -d "." -f 1,2,3)
echo $OCTETS

#the code below is going to loop through and ping every ip on the network

for ip in {1..254}
do  
    ping -c1 $OCTETS.$ip  | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done

sleep 3
