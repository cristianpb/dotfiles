#!/bin/bash

countG=$(ls /home/perezcri/.mail/gmail/Inbox/new | wc -l)
countK=$(ls /home/perezcri/.mail/ministere/Inbox/new | wc -l)
count=$((countG + countK))


if [[ -n "$count" && "$count" -gt 0 ]]; then
    echo "  ${count}"
else
    echo ""
fi
