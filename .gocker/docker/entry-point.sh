#!/bin/bash

LOCKFILE="./vendor/.lockfile"
MANIFEST="Gopkg.toml"

printf "%b" "${PURPLE_BOLD}ENTRY POINT RUNING${NO_COLOR}"

if [ ! -e Gopkg.toml ]; then
  dep init -v
  cp $MANIFEST $LOCKFILE > /dev/null 2>&1
  chown -R gocker:gocker {./vendor,Gopkg.*}
fi

if [ -d ./vendor ]; then
  if ! diff $MANIFEST $LOCKFILE > /dev/null 2>&1; then
    dep ensure
    cp $MANIFEST $LOCKFILE > /dev/null 2>&1
    chown -R gocker:gocker {./vendor,Gopkg.*}
  fi
fi

refresh run
