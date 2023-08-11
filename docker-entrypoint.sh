#!/bin/bash
set -e
if [[ ! -f "$ZOO_CONF_DIR/zoo.cfg" ]]; then
   CONFIG="$ZOO_CONF_DIR/zoo.cfg"
   {
    echo "tickTime=$TICKET_TIME"
    echo "dataDir=$ZOO_DATA_DIR"
    echo "clientPort=${PORT:-2181}"
    echo "initLimit=$ZOO_INIT_LIMIT"
    echo "syncLimit=$ZOO_SYNC_LIMIT"
   } >> "$CONFIG"
 
    if [[ -z $ZOO_SERVERS ]]; then
    ZOO_SERVERS="server.1=localhost:2888:3888"
    fi
    for server in $ZOO_SERVERS; do
    echo "$server" >> "$CONFIG"
    done
    fi

if [[ ! -f "$ZOO_DATA_DIR/myid" ]]; then
    echo "${ZOO_MY_ID:-1}" > "$ZOO_DATA_DIR/myid"
fi
exec "$@"