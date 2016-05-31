# We ahead's configuration container

[![latest 1.0.0](https://img.shields.io/badge/latest-1.0.0-green.svg)](https://github.com/weahead/docker-conf/releases/tag/v1.0.0)

This container is used for providing configuration files generated with 
[confd](https://github.com/kelseyhightower/confd) for other containers via
volumes.

For use with [Rancher](http://rancher.com/) because it 
uses Rancher's [Metadata Service](http://docs.rancher.com/rancher/rancher-services/metadata-service/).


## How to use

Create a folder structure that looks like [`root`](root). Add template 
resources and templates to specified folders. Add a new Dockerfile that looks 
like this:

```
FROM weahead/conf:1.0.0

VOLUME /usr/local/etc/<name>
```

Make sure your template resources are output to the volume location specified
in your Dockerfile.

Build it.


### A note on Docker Hub

The above Dockerfile can be made even simpler by using Dockers `ONBUILD` and 
`ARG` instructions together, leaving just the `FROM` instruction. Unfortunately 
the Docker Hub is still running 1.8, which does not support the `ARG`
instruction. There is an issue tracking the  support for 1.9 features on Docker 
Hub,  [#460](https://github.com/docker/hub-feedback/issues/460)


## License

[X11](LICENSE)
