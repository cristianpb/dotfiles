#!/bin/sh

countG=$(ls /home/arch/Mail/Gmail/INBOX/new | wc -l)
count=$((countG))

if [[ -n "$count" && "$count" -gt 0 ]]; then
    echo "  ${count}"
else
    echo ""
fi
