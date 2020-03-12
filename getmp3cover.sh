#!/bin/bash

#ARTIST=`metaflac --show-tag=ARTIST 01.* | awk -F= '{print $NF}' | sed 's/‐/-/g'`
ALBUM=`ffprobe 01.* 2>&1 | grep "  album" | awk -F: '{print $2}'`
ARTIST=`ffprobe 01.* 2>&1 | grep "  artist" | awk -F: '{print $2}'`
#ALBUM=`metaflac --show-tag=ALBUM 01.* | awk -F= '{print $NF}' | sed 's/‐/-/g'`

echo "artist = $ARTIST"
echo $ARTIST | od -ax
echo "album = $ALBUM"

echo glyrc cover --artist "$ARTIST" --album "$ALBUM" -w cover.png 
glyrc cover --artist "$ARTIST" --album "$ALBUM" -w cover.png || 
glyrc cover --artist \"$ARTIST\" --album \"$ALBUM\" -w cover.png || exit 22
convert cover.png cover.jpg
rm cover.png

for f in *.mp3 ; do 
	eyeD3 --add-image cover.jpg:FRONT_COVER "$f"
done
