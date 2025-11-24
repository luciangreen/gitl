#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <rep_name> <user> <host>"
  echo "Example: $0 my_repo user2 46.250.241.178"
  exit 1
fi

REP_NAME="$1"
USER="$2"
HOST="$3"

swipl -q -s "restore_gitl_data_from_vps_if_newer.pl" \
      -g "restore_gitl_data_from_vps_if_newer('$REP_NAME','$USER','$HOST')" \
      -t halt