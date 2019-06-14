#!/bin/sh

STATE=`nmcli networking connectivity`
mailsync="mbsync --all --quiet"

if [ $STATE = 'full' ]
then
    $mailsync
    exit 0
fi
echo "No internet connection."
exit 0
