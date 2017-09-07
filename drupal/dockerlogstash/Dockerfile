FROM logstash

RUN chmod +x /docker-entrypoint.sh

COPY logstash-simple.conf /logstash-simple.conf
COPY logstash-simple.conf /etc/logstash/conf.d/logstash-simple.conf

RUN mkdir -p /datas/logstash-logs
RUN chmod 777 /datas/logstash-logs

### VOLUME ['/datas/logstash-logs']

CMD ["-flogstash-simple.conf"]
