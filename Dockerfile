FROM  lonly/docker-zeppelin:0.7.3

ARG  VERSION=0.7.3-cn-special
ARG  VCS_REF
ARG  BUILD_DATE

# Docker Meta
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

# Add Ubuntu Repository
RUN set -x \
    && echo "Add Ubuntu Repository" \
    && cp /etc/apt/sources.list /etc/apt/sources.list.old \
    && chmod +rw /etc/apt/sources.list \
    && printf '# deb cdrom:[Ubuntu 16.04 LTS _Xenial Xerus_ - Release amd64 (20160420.1)]/ xenial main restricted \ndeb-src http://archive.ubuntu.com/ubuntu xenial main restricted #Added by software-properties \ndeb http://mirrors.aliyun.com/ubuntu/ xenial main restricted \ndeb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe #Added by software-properties \ndeb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted \ndeb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe #Added by software-properties \ndeb http://mirrors.aliyun.com/ubuntu/ xenial universe \ndeb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe \ndeb http://mirrors.aliyun.com/ubuntu/ xenial multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse #Added by software-properties \ndeb http://archive.canonical.com/ubuntu xenial partner \ndeb-src http://archive.canonical.com/ubuntu xenial partner \ndeb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted \ndeb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe #Added by software-properties \ndeb http://mirrors.aliyun.com/ubuntu/ xenial-security universe \ndeb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse' >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get autoclean \
    && apt-get clean

# Add Pip Repository
RUN set -x \
    && echo "Add Pip Repository" \
    && mkdir ~/.pip \
    && printf '[global] \nindex-url = http://mirrors.aliyun.com/pypi/simple/ \n[install] \ntrusted-host=mirrors.aliyun.com \ndisable-pip-version-check = true \ntimeout = 6000' >> ~/.pip/pip.conf

# Install Machine Learning Pachage
RUN set -x \
    && echo "Install Machine Learning Pachage" \
    && pip install pandas scipy scikit-learn \
    && find /usr/lib/python2.*/ -name 'tests' -exec rm -r '{}' + \
    && find /usr/lib/python3.*/ -name 'tests' -exec rm -r '{}' + \
    && rm /usr/include/xlocale.h  \
    && rm -r /root/.cache \
    && rm -rf /tmp/*

# Update Zeppelin Web
RUN   set -x \
    && echo "Update Zeppelin Web" \
    ## Define var
    && ZEPPELIN_VERSION=0.7.3 \
    ## Chinesize zeppelin web
    ### Enter work dir
	&& cd ${ZEPPELIN_HOME} \
	## Unzip zeppelin web war	
	&& mkdir -p webapp \
	&& unzip -oq zeppelin-web-${ZEPPELIN_VERSION}.war -d webapp \
	## Remove old war
	&& rm -rf zeppelin-web-${ZEPPELIN_VERSION}.war \
	## Enter webapp dir
	&& cd ./webapp/ \
	## Download Chinesization zeppelin web tar
	&& wget -q -c https://github.com/lonly197/zeppelin-web/archive/${VERSION}.tar.gz -O ${VERSION}.tar.gz \
	&& tar xvf ${VERSION}.tar.gz --strip 1 \
	&& rm -rf ${VERSION}.tar.gz \
	## Zip Chinesization war
	&& jar -cvfM0 zeppelin-web-${ZEPPELIN_VERSION}.war ./* \
	&& mv zeppelin-web-${ZEPPELIN_VERSION}.war ${ZEPPELIN_HOME}/ \
    && cd ../ \
    && rm -rf webapp \
    ## Cleanup
    && rm -rf *.tgz *.zip *.tar \
    && rm -rf /tmp/*
    
# Start Zeppelin Server
CMD	 ${ZEPPELIN_HOME}/bin/zeppelin.sh run