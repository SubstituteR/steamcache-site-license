#!/bin/bash

sed -i 's/STEAM_CACHE_SIZE_GB/'"$STEAM_CACHE_SIZE_GB"'/g' steamconsole.cfg
sed -i 's/STEAM_CACHE_CREDS/'"$STEAM_CACHE_CREDS"'/g' steamconsole.cfg

exec "$@"