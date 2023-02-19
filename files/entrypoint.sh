#!/bin/bash

sed -i 's/STEAM_CACHE_SIZE_GB/'"$STEAM_CACHE_SIZE_GB"'/g' /opt/steamcmd/steamconsole.cfg
sed -i 's/STEAM_CACHE_CREDS/'"$STEAM_CACHE_CREDS"'/g' /opt/steamcmd/steamconsole.cfg
sed -i 's/STEAM_CACHE_IP/'"$STEAM_CACHE_IP"'/g' /opt/steamcmd/steamconsole.cfg
sed -i 's/STEAM_CACHE_EXTERNAL/'"$STEAM_CACHE_EXTERNAL"'/g' /opt/steamcmd/steamconsole.cfg
exec "$@"
