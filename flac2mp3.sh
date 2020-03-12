#!/usr/bin/env bash


if [ ! $1 ] ; then
  echo "$0 <dir of flac> <outdir base path>"
  echo "directory of Artist-Album_Name will be created"
  exit 1
fi
DIR=$1

if [ ! $2 ] ; then
  echo "$0 <dir of flac> <outdir base path>"
  echo "directory of Artist-Album_Name will be created"
  exit 1
fi

ODIRPATH=$2

for a in $DIR/*.flac; do
  echo $a
  # give output correct extension
  OUTF="${a[@]/%flac/mp3}"
  echo $OUTF

  # get the tags
  ARTIST=$(metaflac "$a" --show-tag=ARTIST | sed s/.*=//g)
  TITLE=$(metaflac "$a" --show-tag=TITLE | sed s/.*=//g)
  ALBUM=$(metaflac "$a" --show-tag=ALBUM | sed s/.*=//g)
  GENRE=$(metaflac "$a" --show-tag=GENRE | sed s/.*=//g)
  TRACKNUMBER=$(metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g)
  DATE=$(metaflac "$a" --show-tag=DATE | sed s/.*=//g)

  IDIR=$(echo ${OUTF} | awk -F"/" '{print $1}')
  ODIR=$(echo ${ARTIST}-${ALBUM} | sed "s/ /_/g" )
  OFILE=$(echo ${OUTF} | awk -F"/" '{print $NF}')
  #check and create output directory
  echo "output dir: ${ODIRPATH}/${ODIR}"
  echo "output file: ${ODIRPATH}/${ODIR}/${OFILE}"

  #check and create output directory
  mkdir -p ${ODIRPATH}/${ODIR}

  # stream flac into the lame encoder
  flac -c -d "$a" | lame -V0 --add-id3v2 --pad-id3v2 --ignore-tag-errors \
    --ta "$ARTIST" --tt "$TITLE" --tl "$ALBUM"  --tg "${GENRE:-12}" \
    --tn "${TRACKNUMBER:-0}" --ty "$DATE" - "${ODIRPATH}/${ODIR}/${OFILE}"

  #convert cover to jpg
  #convert ${DIR}/cover.png ${ODIRPATH}/${ODIR}/cover.jpg
  #eyeD3 --add-image "${ODIRPATH}/${ODIR}/cover.jpg:FRONT_COVER" "${ODIRPATH}/${ODIR}/${OFILE}"
done


