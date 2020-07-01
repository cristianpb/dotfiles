#!/bin/bash

env HUGO_baseURL="file:///home/${USER}/Documents/vimwiki/_site/" \
    hugo --themesDir ~/Documents/ -t vimwiki \
    --config ~/Documents/vimwiki/config.toml \
    --contentDir ~/Documents/vimwiki/content \
    -d ~/Documents/vimwiki/_site --quiet > /dev/null
