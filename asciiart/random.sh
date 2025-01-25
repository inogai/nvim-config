#!/usr/bin/env bash
SCRIPT_PATH=$(dirname "$0")

if [[ "$1" == 'light' ]]; then
  PATTERN="_light.txt$"
else
  PATTERN="_dark.txt$"
fi

RANDOM_FILENAME=$(fd "$PATTERN" "$SCRIPT_PATH" -d1 | shuf -n 1)
cat "$RANDOM_FILENAME"
