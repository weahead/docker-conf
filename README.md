# We ahead's configuration container

[![latest 3.0.2](https://img.shields.io/badge/latest-3.0.2-green.svg)](https://github.com/weahead/docker-conf/releases/tag/v3.0.2)

This container is used for providing configuration files generated with 
[confd](https://github.com/kelseyhightower/confd) for other containers via
volumes.

This image uses Rancher's [Metadata Service](http://docs.rancher.com/rancher/rancher-services/metadata-service/)
as a backend for confd. When deployed on [Rancher](http://rancher.com/) it will 
properly use Ranchers Metadata service, if it is unavailable due to deployment 
elsewhere (like during development) it will start its own metadata service 
based on a [release of Rancher Metadata](https://github.com/rancher/rancher-metadata/releases).

Both confd and Rancher metadata run as non-root user inside the container.


## How to use

- Create a folder structure that looks like [`root`](root).
- Add [template resources](https://github.com/kelseyhightower/confd/blob/master/docs/template-resources.md) 
- Add [templates](https://github.com/kelseyhightower/confd/blob/master/docs/templates.md) 
- Add a file named `Dockerfile` that looks like this:

```
FROM weahead/conf:3.0.2

VOLUME /usr/local/etc/<name>
```

Make sure your template resources are output to the volume location specified
in your Dockerfile.

Build it.


### How to use the built in Rancher metadata

- Create a YAML file and make it available at `/answers.yml` inside the
  container.
- Edit it to suite your needs.

See example: [answers.example.yml](answers.example.yml)


### A note on Docker Hub

The above Dockerfile can be made even simpler by using Dockers `ONBUILD` and 
`ARG` instructions together, leaving just the `FROM` instruction. Unfortunately 
the Docker Hub is still running 1.8, which does not support the `ARG`
instruction. There is an issue tracking the  support for 1.9 features on Docker 
Hub, [#460](https://github.com/docker/hub-feedback/issues/460)


## License

[X11](LICENSE)
