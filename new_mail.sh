#!/bin/sh

countG=$(ls /home/arch/.mail/gmail/Inbox/new | wc -l)
countM=$(ls /home/arch/.mail/ministere/Inbox/new | wc -l)
count=$((countG + countM))

if [[ -n "$count" && "$count" -gt 0 ]]; then
    echo "  ${count}"
else
    echo ""
fi
