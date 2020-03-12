#!/bin/bash

TOTAL=`ls -1 *.flac|wc -l`

for track in *.flac; do
	echo $track
	echo ${track:0:2}
	echo "removing old metadata"
	metaflac --remove-tag=TRACKNUMBER "$track"
	metaflac --remove-tag=TRACKTOTAL "$track"
	echo "adding correct track number and total"
	metaflac --set-tag=TRACKNUMBER=${track:0:2} $track
	metaflac --set-tag=TRACKTOTAL=$TOTAL $track
done
