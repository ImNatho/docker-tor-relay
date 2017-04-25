FROM alpine:latest
MAINTAINER ImNatho <me@natho.io>

# Switch to testing repo and install TOR (NOTE: TOR is only in the testing repo)
RUN \
  apk update \
  && apk add tor --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
  && rm -rf /var/cache/apk/*

# Expose torrc port
EXPOSE 9001
EXPOSE 9030

# Insert config file
COPY configs/bridge /etc/tor/bridge
COPY configs/middle /etc/tor/middle
COPY configs/exit /etc/tor/exit

# Insert setup script
COPY setup.sh /etc/tor/setup.sh

# Set tor directory file permissions and ownership
RUN chown -R tor /etc/tor
RUN chmod +x /etc/tor/setup.sh

# Run setup script
CMD sh /etc/tor/setup.sh
