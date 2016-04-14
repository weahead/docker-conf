FROM weahead/confd:0.11.0

MAINTAINER Michael Lopez <michael@weahead.se>

ENTRYPOINT ["/confd"]

CMD ["--backend", "rancher", "--prefix", "/2015-12-19"]

ONBUILD COPY root /

# Uncomment when Docker Hub is running 1.9+
# ONBUILD ARG name
# ONBUILD VOLUME /usr/local/etc/${name}
