# docker-zeppelin

![Docker builds](https://img.shields.io/docker/automated/lonly/docker-zeppelin.svg)

> Base and clean [Docker](https://www.docker.com/what-docker) image for [Apache Zeppelin](http://zeppelin.apache.org).

                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o Zeppelin  __/
             \    \         __/
              \____\_______/

> Please use corresponding branches from this repo to play with code.

- ![Version](https://images.microbadger.com/badges/version/lonly/docker-zeppelin:0.7.3.svg) ![Layers](https://images.microbadger.com/badges/image/lonly/docker-zeppelin:0.7.3.svg) __0.7.3 = 0.7 = latest__

- ![Version](https://images.microbadger.com/badges/version/lonly/docker-zeppelin:0.7.3-cn.svg) ![Layers](https://images.microbadger.com/badges/image/lonly/docker-zeppelin:0.7.3-cn.svg) __0.7.3-cn__

- ![Version](https://images.microbadger.com/badges/version/lonly/docker-zeppelin:0.7.3-cn-special.svg) ![Layers](https://images.microbadger.com/badges/image/lonly/docker-zeppelin:0.7.3-cn-special.svg) __0.7.3-cn-special__

- ![Version](https://images.microbadger.com/badges/version/lonly/zeppelin:0.7.2.svg) ![Layers](https://images.microbadger.com/badges/image/lonly/docker-zeppelin:0.7.2.svg) __0.7.2__

- ![Version](https://images.microbadger.com/badges/version/lonly/zeppelin:0.7.2-cn.svg) ![Layers](https://images.microbadger.com/badges/image/lonly/docker-zeppelin:0.7.2-cn.svg) __0.7.2-cn__

## Overview

Deployment options out of the box:

Dockerized single-host Zeppelin.

Deployment options out of the box:
- Standalone Zeppelin node

## Build

```bash
docker build \
--rm \
-t lonly/docker-zeppelin:0.7.3 \
--build-arg VCS_REF=`git rev-parse --short HEAD` \
--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` .
```

## Exposed ports

- 8080 - Zeppelin web application port
- 8443 - Zeppelin web application secure port


## Volumes

All below volumes can be mounted to docker host machine folders or shared folders to easy maintain data inside them. 

Zeppelin-specific:
opt/zeppelin/conf
/opt/zeppelin/logs
/opt/zeppelin/notebook
/opt/zeppelin/local-repo
/opt/zeppelin/helium


## Official Documentation and Guides

- [Overview](http://zeppelin.apache.org/docs/0.7.3)
- [Quick Start](http://zeppelin.apache.org/docs/0.7.3/install/install.html)
- [Interpreters](http://zeppelin.apache.org/docs/0.7.3/manual/interpreters.html)
- [Wiki](https://cwiki.apache.org/confluence/display/ZEPPELIN/Zeppelin+Home)

## Usage

This image can either be used as a base image for building on top of NiFi or just to experiment with. I personally have not attempted to use this in a production use case.

Please use corresponding branches from this repo to play with code.


## Pre-Requisites
Ensure the following pre-requisites are met (due to some blocker bugs in earlier versions). As of today, the latest Docker Toolbox and Homebrew are fine.

- Docker 1.10+
- Docker Machine 0.6.0+

(all downloadable as a single [Docker Toolbox](https://www.docker.com/products/docker-toolbox) package as well)

## How to use from Docker CLI

1. Start Docker Quickstart Terminal
2. Run command  `docker run -d -p 8080:8080 -p 8443:8443 --name zeppelin lonly/docker-zeppelin`
3. Check Docker Contianer Running Status `docker ps -a`
4. Use IP from previous step in address bar of your favorite browser, e.g. ` http://192.168.1.1:8080/#/`

## License

![License](https://img.shields.io/github/license/lonly197/docker-zeppelin.svg)

## Contact me

- Email: <lonly197@qq.com>