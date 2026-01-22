#!/usr/bin/env bash
#set -euo pipefail
set -euxo pipefail

#mc alias set myminio $MINIO_ENDPOINT $AWS_ACCESS_KEY_ID  $AWS_SECRET_ACCESS_KEY

LOG="/tmp/bootstrap.log"
exec > >(tee -a "$LOG") 2>&1

INSTANCE_NAME="$(hostname)"
NAME_LOWER=$(echo "$INSTANCE_NAME" | tr '[:upper:]' '[:lower:]')
entries=(
"192.168.1.60 Master-01"
"192.168.1.61 Master-02"
"192.168.1.62 Master-03"
"192.168.1.63 Worker-01"
"192.168.1.64 Worker-02"
"192.168.1.65 Worker-03"

)

for entry in "${entries[@]}"; do
    ip=$(echo "$entry" | awk '{print $1}')
    host=$(echo "$entry" | awk '{print $2}')

    # Check if entry already exists
    if grep -qE "^$ip[[:space:]]+$host$" /etc/hosts; then
        echo "Entry already exists: $entry"
    else
        echo "Adding: $entry"
        echo "$entry" | sudo tee -a /etc/hosts > /dev/null
    fi
done