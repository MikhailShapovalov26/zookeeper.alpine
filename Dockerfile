FROM alpine:latest
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
ENV ZOO_VERSION=zookeeper-3.8.2 \
    ZOOKEEP_DIR=/opt/zookeeper \
    TICKET_TIME=2000 \
    ZOO_CONF_DIR=/opt/zookeeper/conf \
    ZOO_DATA_DIR=/data \
    ZOO_DATA_LOG_DIR=/datalog \
    ZOO_LOG_DIR=/logs \
    ZOO_TICK_TIME=2000 \
    ZOO_INIT_LIMIT=5\
    ZOO_SYNC_LIMIT=2 \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk

RUN apk update && apk upgrade \
    && apk --no-cache add --update wget curl git tar bash ca-certificates  openjdk11 tzdata \
    && wget --no-verbose http://apache.osuosl.org/zookeeper/"$ZOO_VERSION"/apache-"$ZOO_VERSION"-bin.tar.gz \
    && tar -xvf apache-"$ZOO_VERSION"-bin.tar.gz  \
    && mkdir -p "$ZOO_DATA_LOG_DIR" "$ZOO_DATA_DIR" "$ZOO_CONF_DIR" "$ZOO_LOG_DIR" "$ZOOKEEP_DIR" \
    && cp -r apache-"$ZOO_VERSION"-bin/* "$ZOOKEEP_DIR" \
    &&  rm -rf /var/cache/apk/* \
    && rm -rf /apache-"$ZOO_VERSION"-bin apache-"$ZOO_VERSION"-bin.tar.g
RUN set -eux;\
    addgroup -g 1000 zookeeper;  \
    adduser --disabled-password --ingroup zookeeper   --no-create-home --uid 1000 zookeeper;\
    chown zookeeper:zookeeper "$ZOOKEEP_DIR" "$ZOO_DATA_LOG_DIR" "$ZOO_DATA_DIR" "$ZOO_CONF_DIR" "$ZOO_LOG_DIR"
WORKDIR "$ZOOKEEP_DIR"
VOLUME ["$ZOO_DATA_DIR", "$ZOO_DATA_LOG_DIR", "$ZOO_LOG_DIR"]
EXPOSE 2181 2888 3888 8080
ENV PATH=$PATH:$ZOOKEEP_DIR/bin \
     ZOOCFGDIR=$ZOO_CONF_DIR
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh" ]
CMD [ "zkServer.sh", "start-foreground" ]