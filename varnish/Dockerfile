FROM centos:centos7
MAINTAINER AF Data Systems GmbH

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y varnish && \
    yum install -y libmhash-devel && \
    yum clean all


ADD start.sh /start.sh
ADD default.vcl /etc/varnish/default.vcl
ADD varnish.params /etc/varnish/varnish.params

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600
ENV VARNISH_PORT 80

CMD /start.sh
EXPOSE 80 6082