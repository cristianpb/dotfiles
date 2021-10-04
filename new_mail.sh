#!/bin/sh

countG=$(ls $HOME/.mail/gmail/Inbox/new | wc -l)
count=$((countG + countM))

if [[ -n "$count" && "$count" -gt 0 ]]; then
    echo "  ${count}"
else
    echo ""
fi
