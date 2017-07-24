#!/usr/bin/env bash
#Market options: en-US, zh-CN, ja-JP, en-AU, en-UK, de-DE, en-NZ
#Resolution options: 1366×768, 1920×1080, 1920×1200
Market="en-US"
Resolution="1920x1080"
Directory="$HOME/Images/Wallpaper/"
FileName="wallpaper.jpg"
FileNamepng="wallpaper.png"

#mkdir -pv "$Directory"

URL=($(curl -s 'http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt='"$Market" | python -c "import json,sys;obj=json.load(sys.stdin);print(obj['images'][0]['urlbase']);"))
ImageURL="http://www.bing.com"/$URL"_"$Resolution".jpg"
echo "Downloading Bing image to: $Directory"
curl -so "$Directory"/$FileName "$ImageURL"
convert "$Directory"/$FileName "$Directory"/$FileNamepng
rm $FileName 
