#!/bin/sh

watson_status=$(watson status -p)
no_project="No project started"

echo "$watson_status"

#if [ "$watson_status" == "$no_project" ]; then
#  echo "Nothing"
#fi
