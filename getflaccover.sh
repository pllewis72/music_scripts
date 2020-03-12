#!/bin/bash

ARTIST=`metaflac --show-tag=ARTIST 01.* | awk -F= '{print $NF}' | sed 's/‐/-/g'`
ALBUM=`metaflac --show-tag=ALBUM 01.* | awk -F= '{print $NF}' | sed 's/‐/-/g'`

echo "artist = $ARTIST"
echo $ARTIST | od -ax
echo "album = $ALBUM"

echo glyrc cover --artist "$ARTIST" --album "$ALBUM" -w cover.png 
glyrc cover --artist "$ARTIST" --album "$ALBUM" -w cover.png || 
glyrc cover --artist \"$ARTIST\" --album \"$ALBUM\" -w cover.png || 
exit 22

for f in *.flac ; do 
	 metaflac --import-picture-from=cover.png $f 
done
