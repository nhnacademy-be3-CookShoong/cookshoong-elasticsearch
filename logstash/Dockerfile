ARG ELK_VERSION

FROM docker.elastic.co/logstash/logstash:${ELK_VERSION}

RUN curl -Lo "mysql-connector-j-8.0.33.tar.gz" "https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-j-8.0.33.tar.gz" \
    && tar -xf "mysql-connector-j-8.0.33.tar.gz" "mysql-connector-j-8.0.33/mysql-connector-j-8.0.33.jar" \
    && mv "mysql-connector-j-8.0.33/mysql-connector-j-8.0.33.jar" "mysql-connector-j-8.0.33.jar" \
    && rm -r "mysql-connector-j-8.0.33" "mysql-connector-j-8.0.33.tar.gz"

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
