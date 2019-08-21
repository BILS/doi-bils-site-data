#!/bin/sh

if [ "$#" -ne 2 ]; then
  printf 'Usage: %s <data directory> <email>\n' "$0" >&2
  exit 1
fi

DATADIR=$1
EMAIL=$2
DEBUG=1

cd "$DATADIR" || {
    printf 'Failed changing directory to %s\n' "$DATADIR" >&2
    exit 1
}


echo "Subject:DOI validation \n\n" > validation.txt
if perl validate.pl | tee -a validation.txt | grep -q '^Bad'; then
  sendmail "$EMAIL" <validation.txt
elif(DEBUG==1) then
  sendmail "$EMAIL" <validation.txt  
  echo "sendmail "$EMAIL" <validation.txt"
fi
