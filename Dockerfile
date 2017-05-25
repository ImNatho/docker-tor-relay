FROM alpine:latest
MAINTAINER ImNatho <me@natho.io>

# Insert config dir
COPY configs /etc/tor

# Switch to testing repo and install TOR (NOTE: TOR is only in the testing repo)
RUN apk update && apk add tor --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ && rm -rf /var/cache/apk/*

# Set tor directory file permissions and ownership
RUN chown -R tor /etc/tor
RUN chmod +x /etc/tor/start.sh

# Expose torrc port
EXPOSE 9001
EXPOSE 9030

# Run setup script
CMD [ "sh", "/etc/tor/start.sh" ]
