#!/bin/bash

count=$1

for file in *.flac ; do 
	#echo $file
	track=${file:0:2}
	fname=${file:2}
	newt=$(expr $track + $count)
	#echo $track $newt $fname
	mv "$file" "${newt}$fname"
done
