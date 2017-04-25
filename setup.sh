#!/bin/bash

if [ -z "$TYPE" ]; then
  exit 1
fi

function append_or_replace {
  if [ -z "$(grep -e "^$1.*$" $TYPE)" ]; then
    echo "$1 $2" >> $TYPE
  else
    sed -i "s/^$1.*/$1 $2/g" $TYPE
  fi
}

if [ -n "$NICKNAME" ]; then
  append_or_replace 'Nickname' "$NICKNAME"
else
  exit 1
fi

if [ -n "$CONTACT_NAME" && -n "$CONTACT_EMAIL" ]; then
  if [ -n "$CONTACT_GPG"]; then
    append_or_replace 'ContactInfo' "$CONTACT_GPG $CONTACT_NAME <$CONTACT_EMAIL>"
  else
    append_or_replace 'ContactInfo' "$CONTACT_NAME <$CONTACT_EMAIL>"
  fi
else
  append_or_replace 'ContactInfo' 'Anonymous'
fi

# Copy config to main config location
cp $TYPE /etc/tor/torrc -f
# Start tor with set config
tor -f /etc/tor/torrc
