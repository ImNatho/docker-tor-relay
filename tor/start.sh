#!/bin/bash

# Copy config to main config location
cp /etc/tor/$TYPE /etc/tor/torrc -f

function append_or_replace {
  if [ -z "$(grep -e "^$1.*$" /etc/tor/torrc)" ]; then
    echo "$1 $2" >> $TYPE
  else
    sed -i "s/^$1.*/$1 $2/g" /etc/tor/torrc
  fi
}

if [ -z "$NICKNAME" ]; then
  echo "Setup: No Nickname Provided"
else
  append_or_replace 'Nickname' "$NICKNAME"
fi

if [ -z "$CONTACT_INFO" ]; then
  echo "Setup: No Contact Info Provided"
else
  append_or_replace 'ContactInfo' "$CONTACT_INFO"
fi

# Start tor with set config
tor -f /etc/tor/torrc
