# Mpd client

## MCP Party client (web mdp client)

* Clone mpcparty `git clone https://github.com/jplsek/MPCParty`. By default at `~/Documents/node/`

* Install dependencies `npm install`

* You can test using `npm start`

* Create a service at `~/.config/systemd/user/mpcparty.service`

```
# mpcparty.service

[Unit]
Description=MPCParty
After=mpd.service

[Service]
ExecStart=/usr/bin/node /home/arch/Documents/node/MPCParty/server.js
Restart=always

[Install]
WantedBy=multi-user.target
```

* Enable service `systemctl --user enable mpcparty.service`


## Album notification http://dotshare.it/dots/1533/

Find album in folder and send notification

```bash
MUSIC_DIR=/home/cris/Music_clean #path to your music dir

COVER=/tmp/cover.jpg

function reset_background
{
    printf "\e]20;;100x100+1000+1000\a"
}

{
    title="$(mpc --format %title% current)"
    artist="$(mpc --format %artist% current)"
    album="$(mpc --format %album% current)"
    file="$(mpc --format %file% current)"
    album_dir="${file%/*}"
    [[ -z "$album_dir" ]] && exit 1
    album_dir="$MUSIC_DIR/$album_dir"

    covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\|gif\|bmp\)" \; )"
    src="$(echo -n "$covers" | head -n1)"
    rm -f "$COVER" 
    if [[ -n "$src" ]] ; then
        #resize the image's width to 300px 
        convert "$src" -resize 100x "$COVER"
        if [[ -f "$COVER" ]] ; then
           #scale down the cover to 30% of the original
           #printf "\e]20;${COVER};70x70+0+00:op=keep-aspect\a"
           notify-send --urgency=low --expire-time=5000 --app-name=ncmpcpp \
           --icon="$COVER" "$album" "$artist\n$title"
        else
            reset_background
        fi
    else
        reset_background
    fi
} &
```


## Vim bindings https://gist.github.com/Soft/959188

```python
# ~/.ncmpcpp/bindings
# the t key isn't used and it's easier to press than /, so lets use it
def_key "t"
    find
def_key "t"
    find_item_forward

def_key "+"
    show_clock
def_key "="
    volume_up

def_key "j"
    scroll_down
def_key "k"
    scroll_up

def_key "ctrl-u"
    page_up
#push_characters "kkkkkkkkkkkkkkk"
def_key "ctrl-d"
    page_down
#push_characters "jjjjjjjjjjjjjjj"

def_key "h"
    previous_column
def_key "l"
    next_column

def_key "."
    show_lyrics

def_key "n"
    next_found_item
def_key "N"
    previous_found_item

# not used but bound
def_key "J"
    move_sort_order_down
def_key "K"
    move_sort_order_up
```

