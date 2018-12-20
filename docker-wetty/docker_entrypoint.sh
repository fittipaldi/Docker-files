#!/bin/bash

set -e

WETTY_PASSWORD_FILE=${WETTY_PASSWORD_FILE:-}
WETTY_PASSWORD=${WETTY_PASSWORD:-term}
WETTY_USER=${WETTY_USER:-term}
WETTY_USERS_FILE=${WETTY_USERS_FILE:-}

if [ ! -z "$WETTY_PASSWORD_FILE" ]; then
  WETTY_PASSWORD=$(tail -n 1 $WETTY_PASSWORD_FILE)
fi

if [ ! -z "$WETTY_USER" ] && [ ! -z "$WETTY_PASSWORD" ]; then
  useradd -d /home/$WETTY_USER -m -s /bin/bash $WETTY_USER
  echo "${WETTY_USER}:${WETTY_PASSWORD}" | chpasswd
fi

if [ ! -z "$WETTY_USERS_FILE" ]; then
 while read line; do
   user=$(echo $line | cut -d':' -f1)

   useradd -d /home/$user -m -s /bin/bash $user || true
   chown -R $user: /home/$user
 done < "$WETTY_USERS_FILE"

 cat "$WETTY_USERS_FILE" | chpasswd
fi

exec "$@"
