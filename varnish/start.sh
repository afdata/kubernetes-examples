#!/bin/bash

set -e

if [ -z $HTTPHOST ] ; then
  HTTPHOST=localhost
fi

sed -i "s/@@HTTPHOST@@/$HTTPHOST/g"  /etc/varnish/default.vcl

exec bash -c \
  "exec varnishd -F -u varnish \
  -f $VCL_CONFIG \
  -s malloc,$CACHE_SIZE \
  $VARNISHD_PARAMS"
