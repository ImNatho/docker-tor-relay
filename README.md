# Simple Dockerized Tor Relay

A simple docker container that runs a tor relay.
This container is configured to listen on port 9001 for the relay traffic. Make sure this port is open in your firewall.

## Usage

### Just Run The Bloody Thing
If you just want to run the relay, execute the following command.
```
docker run -d \
  --restart=always \
  -e 'TYPE=middle' \
  -e 'NICKNAME=hacktheplanet' \
  --name tor-relay \
  imnatho/tor-relay
```

### Configuration

#### Type

There are three types of TOR relays you can run: bridge, middle and exit.
The type of relay can be set with the following tag.

```
-e 'TYPE=middle' \
```

#### Nickname

It is required that you provide a Nickname for your relay. You can do this using the following flag.

```
-e 'NICKNAME=SpaceDangerNoodle' \
```

#### Contact Information

It is also recommended that you provide your contact information. This is mostly used in case there is something wrong with your node.
You can provide this information with the following flags.

```
-e 'CONTACT_NAME=John Smith' \
-e 'CONTACT_EMAIL=john.smith@example.com' \
-e 'CONTACT_GPG=YOUR-GPG-KEY-HERE' \ # Optional
```

```
docker run -d \
  --restart=always \
  -e 'CONFIG=middle' \
  -e 'NICKNAME=SpaceDangerNoodle' \
  -e 'CONTACT_NAME=John Smith' \
  -e 'CONTACT_EMAIL=john.smith@example.com' \
  -e 'CONTACT_GPG=YOUR-GPG-KEY-HERE' \
  --name tor-relay \
  imnatho/tor-relay
```
