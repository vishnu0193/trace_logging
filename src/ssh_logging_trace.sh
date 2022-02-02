#!/bin/bash

# identify the ssh logs in ubuntu server
ssh_log_file=/var/log/auth.log


# Collect the successful login attempts
ssh_success_log=/tmp/ssh_success.log
egrep "Accepted password|Accepted publickey|keyboard-interactive" $ssh_log_file > $ssh_success_log

# extract the users who successfully logged in
users=$(cat $ssh_success_log | awk '{ print $(NF-5) }' | sort | uniq)
# extract the IP Addresses of successful and failed login attempts

ip_list="$(egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" $ssh_success_log | sort | uniq)"



for ip in $ip_list;
do
  for user in $users;
    do
    # Count successful login attempts by this user from this IP
    attempts=`grep $ip $ssh_success_log | grep " $user " | wc -l`

    if [ $attempts -ne 0 ]
    then
      first_time=`grep $ip $ssh_success_log | grep " $user " | head -1 | cut -c-16`
      time="$first_time"
      if [ $attempts -gt 1 ]
      then
        last_time=`grep $ip $ssh_success_log | grep " $user " | tail -1 | cut -c-16`
        time="$first_time -> $last_time"
      fi
      HOST=$(host $ip 8.8.8.8 | tail -1 | awk '{ print $NF }' )
      echo $attempts "ssh attemps are done by" $ip >> /tmp/ssh_attempts.log
    fi
  done
done
rm -f $ssh_success_log

