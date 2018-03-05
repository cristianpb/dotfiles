#!/bin/sh

countG=$(ls /home/arch/Mail/Gmail/INBOX/new | wc -l)
countK=$(ls /home/arch/Mail/Kernix/INBOX/new | wc -l)
count=$((countG + countK))

if [[ -n "$count" && "$count" -gt 0 ]]; then
    echo "  ${count}"
else
    echo ""
fi
