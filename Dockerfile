# Not for a production usage, just a simple playground to show what you can do with Otoroshi
FROM openjdk:8

MAINTAINER MAIFX Team <maifx@maif.fr>

ENV APP_NAME opun-izanami
ENV APP_VERSION 1.0.0-SNAPSHOT

RUN mkdir -p /usr/app/src && mkdir -p /usr/app/dist

COPY . /usr/app/src

WORKDIR /usr/app/src

RUN unzip ./universal/${APP_NAME}-${APP_VERSION}.zip -d /usr/app/dist \
  && chmod +x /usr/app/dist/${APP_NAME}-${APP_VERSION}/bin/${APP_NAME} \
  && mv ./entrypoint.sh /usr/app/dist/${APP_NAME}-${APP_VERSION} \
  && chmod +x /usr/app/dist/${APP_NAME}-${APP_VERSION}/entrypoint.sh

RUN mkdir /leveldb

VOLUME /leveldb

WORKDIR /usr/app/dist/${APP_NAME}-${APP_VERSION}

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8080

CMD
