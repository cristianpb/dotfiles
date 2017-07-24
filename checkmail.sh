#!/bin/sh

STATE=`nmcli networking connectivity`
mailsync="offlineimap -u quiet -q"

if [ $STATE = 'full' ]
then
    $mailsync
    exit 0
fi
echo "No internet connection."
exit 0
