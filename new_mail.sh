#!/bin/sh

countG=$(ls /home/cris/Mail/Gmail/INBOX/new | wc -l)
countK=$(ls /home/cris/Mail/Kernix/INBOX/new | wc -l)
count=$((countG + countK))

if [[ -n "$count" && "$count" -gt 0 ]]; then
    echo "  ${count}"
else
    echo ""
fi
