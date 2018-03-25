#!/usr/bin/bash


MUSIC_DIR=/home/arch/Music_clean #path to your music dir

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
           --icon="$COVER" "$title" "$artist\n$album"
        else
            reset_background
        fi
    else
        reset_background
    fi
} &

#### Get fields from mpc, split by tabs.
###IFS=$'\t' read album artist title \
###  <<< "$(mpc --format="%album%\t%artist%\t%title%")"
###
####OFS=$'\t' read path_file \
####  <<< "$(mpc --format="%file%")"
###
###
###MUSIC_DIR=/home/cris/Music #path to your music dir
###
###COVER=/tmp/cover.jpg
###
###album="$(mpc --format %album% current)"
###file="$(mpc --format %file% current)"
###album_dir="${file%/*}"
###[[ -z "$album_dir" ]] && exit 1
###album_dir="$MUSIC_DIR/$album_dir"
###
###covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\|gif\|bmp\)" \; )"
###echo $covers
###src="$(echo -n "$covers" | head -n1)"
####rm -f "$COVER" 
####if [[ -n "$src" ]] ; then
####    #resize the image's width to 300px 
####    convert "$src" -resize 300x "$COVER"
####    if [[ -f "$COVER" ]] ; then
####        echo $covers
###
###notify-send --urgency=low --expire-time=5000 --app-name=ncmpcpp \
###--icon="/home/cris/cover.jpg" "$covers" "$artist\n$title"
