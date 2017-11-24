FROM       alpine:3.6

ARG        DIST_MIRROR=http://archive.apache.org/dist/zeppelin
ARG        VERSION=0.7.3

LABEL \
    maintainer="lonly197@qq.com" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="lonly197/zeppelin" \
    org.label-schema.url="https://github.com/lonly197" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-url="https://github.com/lonly197/docker-zeppelin"

ENV        ZEPPELIN_HOME=/opt/zeppelin \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
RUN        set -x \
    ## fix 'ERROR: http://dl-cdn.alpinelinux.org/alpine/v3.6/main: BAD archive'
    && echo http://mirrors.aliyun.com/alpine/v3.6/main/ >> /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/v3.6/community/>> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache --upgrade bash curl jq openjdk8 && \
    mkdir -p ${ZEPPELIN_HOME} && \
    ## download zeppelin package
    curl ${DIST_MIRROR}/zeppelin-${VERSION}/zeppelin-${VERSION}-bin-all.tgz | tar xvz -C ${ZEPPELIN_HOME} && \
    mv ${ZEPPELIN_HOME}/zeppelin-${VERSION}-bin-all/* ${ZEPPELIN_HOME} && \
    ## cleanup
    rm -rf ${ZEPPELIN_HOME}/zeppelin-${VERSION}-bin-all && \
    rm -rf *.tgz && \
    rm -rf /var/cache/apk/* \
    && rm -rf /tmp/nativelib \
    && apk del .builddeps 
EXPOSE     8080 8443
VOLUME     ${ZEPPELIN_HOME}/logs \
    ${ZEPPELIN_HOME}/notebook
WORKDIR    ${ZEPPELIN_HOME}
CMD        ./bin/zeppelin.sh run