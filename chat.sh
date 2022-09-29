#!usr/bin/bash

zmodload zsh/net/tcp

host=$1
port=$2

echo "===== ESTABLISHING CONNECTION ====="

#First act as client on the port
#ztcp localhost 5123
ztcp $host $port
fd=$REPLY 

echo "==== REESTABLISHING CONNECTION ===="
echo "== ACTING AS HOST ON PORT" $port '=='
#If that fails then try to act as the host
ztcp -l $port
listenfd=$REPLY
ztcp -a $listenfd
fd=$REPLY

echo "== THE CONNECTION WAS ESTABLISHED ==" 
echo "type 'quit' to exit"

usr_input=''
prev_line=''

while true 
do  
    read -t 1 line <&$fd 

    if [ "$prev_line" != "$line" ] 
    then
      echo $line
    fi

    prev_line="$line"
    read -t 1 usr_input  

    print $usr_input >&$fd
    if [ "$usr_input" = 'quit' ]
    then
        break 1
    fi
done
ztcp -c

echo "======== CONNECTION CLOSED =========="
