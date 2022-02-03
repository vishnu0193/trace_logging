#!/bin/bash
sudo rm -rf /tmp/auth.txt

if grep -q "Accepted publickey" /var/log/auth.log
then
    cat  /var/log/auth.log | grep 'sshd'| grep 'ubuntu from' |uniq |awk '{print $11}'|uniq -c | sort -nr >> /tmp/auth.txt
    while read count node; do
    echo "$count ssh log-in attempts were made by  $node"
    done < /tmp/auth.txt
else
    exit
fi