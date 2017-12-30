#!/bin/sh

countG=$(ls /Users/cperez/Mail/Gmail/INBOX/new | wc -l)
countK=$(ls /Users/cperez/Mail/Kernix/INBOX/new | wc -l)
count=$((countG + countK))

if [[ -n "$count" && "$count" -gt 0 ]]; then
    echo "  ${count}"
else
    echo ""
fi
