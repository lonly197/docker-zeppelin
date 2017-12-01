FROM  apache/zeppelin:0.7.3

ARG  VERSION=0.7.3
ARG  VCS_REF

LABEL \
    maintainer="lonly197@qq.com" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="lonly/docker-zeppelin" \
    org.label-schema.url="https://github.com/lonly197" \
    org.label-schema.description="This is a full Docker image for Apache Zeppelin, based on Official image." \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/lonly197/docker-zeppelin" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vendor="lonly197@qq.com" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

# Define environment
ENV   ZEPPELIN_HOME=/opt/zeppelin

RUN   set -x \
    ## Make work dir
    && mkdir -p /opt \
    && ln -s /zeppelin ${ZEPPELIN_HOME} \
    ## cleanup
    && rm -rf *.tgz *.zip *.tar \
    && rm -rf /tmp/*

# Define port
EXPOSE  8080 8443

# Define volumn
VOLUME ${ZEPPELIN_HOME}/conf \
	${ZEPPELIN_HOME}/logs \
	${ZEPPELIN_HOME}/notebook \
	${ZEPPELIN_HOME}/local-repo \
	${ZEPPELIN_HOME}/helium

# Define work dir
WORKDIR  ${ZEPPELIN_HOME}

# Start Zeppelin Server
CMD  ./bin/zeppelin.sh run