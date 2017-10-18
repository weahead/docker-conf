FROM alpine:3.6

LABEL maintainer="We ahead <docker@weahead.se>"

ENV CONFD_VERSION=0.12.1\
    S6_VERSION=1.19.1.1\
    RANCHER_METADATA_VERSION=0.9.0\
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN apk --no-cache add --virtual build-deps\
    curl \
    tar \
    gnupg \
    libcap \
  && cd /tmp \
  && curl -OL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-amd64.tar.gz" \
  && curl -OL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-amd64.tar.gz.sig" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver pgp.mit.edu --recv-key 0x337EE704693C17EF \
  && gpg --batch --verify /tmp/s6-overlay-amd64.tar.gz.sig /tmp/s6-overlay-amd64.tar.gz \
  && tar -xzf /tmp/s6-overlay-amd64.tar.gz -C / \
  && curl -L -o /confd "https://github.com/bacongobbler/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64" \
  && chmod +x /confd \
  && curl -OL "https://github.com/rancher/rancher-metadata/releases/download/v${RANCHER_METADATA_VERSION}/rancher-metadata.tar.gz" \
  && mkdir -p /rancher-metadata \
  && tar -C /rancher-metadata/ --strip-components=1 -zxf /tmp/rancher-metadata.tar.gz \
  && setcap 'cap_net_bind_service=+ep' /rancher-metadata/bin/rancher-metadata \
  && rm -rf "$GNUPGHOME" /tmp/* \
  && apk del build-deps

COPY services.d/ /etc/services.d/

ONBUILD COPY root /

ONBUILD RUN chown -R nobody:nobody /usr/local/etc

ENTRYPOINT ["/init"]

# Uncomment when Docker Hub is running 1.9+
# ONBUILD ARG name
# ONBUILD VOLUME /usr/local/etc/${name}
