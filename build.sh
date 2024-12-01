#!/bin/sh
source lib/functions.sh
if [ -f "${package}.sh" ]; then
  source ./${package}.sh
fi
create_bundles
