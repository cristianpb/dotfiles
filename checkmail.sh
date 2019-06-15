#!/bin/sh

STATE=`nmcli networking connectivity`
mailsync="mbsync --quiet gmail "

if [ $STATE = 'full' ]
then
    $mailsync
    exit 0
fi
echo "No internet connection."
exit 0
