# Not for a production usage, just a simple playground to show what you can do with Otoroshi
FROM openjdk:8

MAINTAINER MAIFX Team <maifx@maif.fr>

ENV APP_NAME opun-izanami
ENV APP_VERSION 1.0.6-SNAPSHOT
ENV LEVEL_DB_PARENT_PATH /leveldb
ENV REDIS_PORT 6379
ENV REDIS_HOST redis
ENV CASSANDRA_HOST cassandra
ENV CASSANDRA_PORT 9042
ENV CASSANDRA_REPLICATION_FACTOR 1
ENV CASSANDRA_KEYSPACE izanami
ENV KAFKA_HOST kafka
ENV KAFKA_PORT 9092
ENV HTTP_PORT 8080
ENV APPLICATION_SECRET 123456

RUN mkdir -p /usr/app/src && mkdir -p /usr/app/dist

COPY . /usr/app/src

WORKDIR /usr/app/src

RUN unzip ./${APP_NAME}-${APP_VERSION}.zip -d /usr/app/dist \
  && chmod +x /usr/app/dist/${APP_NAME}-${APP_VERSION}/bin/${APP_NAME} \
  && mv ./entrypoint.sh /usr/app/dist/${APP_NAME}-${APP_VERSION} \
  && chmod +x /usr/app/dist/${APP_NAME}-${APP_VERSION}/entrypoint.sh

RUN mkdir /leveldb

VOLUME /leveldb

WORKDIR /usr/app/dist/${APP_NAME}-${APP_VERSION}

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 2551
EXPOSE 8080

CMD [""]
