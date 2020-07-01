#!/bin/bash

hugo --themesDir ~/Documents/ -t vimwiki \
    --config ~/Documents/vimwiki/config.toml \
    --contentDir ~/Documents/vimwiki/content \
    -d ~/Documents/vimwiki/_site --quiet
