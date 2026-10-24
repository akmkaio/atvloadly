# Home Assistant add-on wrapper for atvloadly.
# Pin the base image to the version tested by the maintainer; bump deliberately.
FROM ghcr.io/bitxeno/atvloadly:v0.7.4

USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       avahi-daemon \
       dbus \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY run.sh /run-atvloadly-ha.sh
RUN chmod 0755 /run-atvloadly-ha.sh

LABEL io.hass.type="app" \
      io.hass.arch="amd64" \
      org.opencontainers.image.title="atvloadly Home Assistant add-on" \
      org.opencontainers.image.source="https://github.com/akmkaio/atvloadly"

ENTRYPOINT ["/run-atvloadly-ha.sh"]
