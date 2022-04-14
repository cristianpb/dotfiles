#!/bin/bash

countG=$(ls /home/ubuntu/.mail/gmail/Inbox/new | wc -l)
count=$((countG))


if [[ -n "$count" && "$count" -gt 0 ]]; then
    echo "  ${count}"
else
    echo ""
fi
