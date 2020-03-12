#!/bin/bash


for track in *.flac; do
	echo $track
	title=`echo $track | awk -F\. '{print $2}' | sed 's/_/ /g'`
	echo title: $title
	echo "removing old metadata"
	metaflac --remove-tag=TITLE "$track"
	echo "adding new metadata"
	echo metaflac --set-tag=TITLE=\"${title}\" \"$track\" | bash
	#@metaflac --set-tag=TITLE=\"${title}\" \"$track\"
	#metaflac --remove-tag=TRACKNUMBER "$track"
	#metaflac --remove-tag=TRACKTOTAL "$track"
	#echo "adding correct track number and total"
	#metaflac --set-tag=TRACKNUMBER=${track:0:2} $track
	#metaflac --set-tag=TRACKTOTAL=$TOTAL $track
done
