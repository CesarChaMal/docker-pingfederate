FROM adoptopenjdk/openjdk8:alpine
MAINTAINER ilanyu <lanyu19950316@gmail.com>

COPY docker-entrypoint.sh /entrypoint.sh

RUN apk add --update --no-cache ca-certificates curl bash

RUN curl -SL https://s3.amazonaws.com/pingone/public_downloads/pingfederate/9.3.1/pingfederate-9.3.1.tar.gz | tar -zxC /usr/local/ && \
    mv /usr/local/pingfederate-9.3.1/pingfederate /usr/local/pingfederate-1 && \
    rm -rf pingfederate-9.3.1

RUN curl -SL -o /usr/local/OAuthPlayground-4.2.zip https://github.com/ilanyu/docker-pingfederate/releases/download/kit/OAuthPlayground-4.2.zip && \
    unzip /usr/local/OAuthPlayground-4.2.zip && \
    mv /usr/local/OAuthPlayground-4.2/dist/deploy/* /usr/local/pingfederate-1/server/default/deploy/ && \
    mv /usr/local/OAuthPlayground-4.2/dist/conf/* /usr/local/pingfederate-1/server/default/conf/ && \
    rm -rf /usr/local/OAuthPlayground-4.2.zip && \
    rm -rf /usr/local/OAuthPlayground-4.2

RUN chmod a+x /entrypoint.sh

EXPOSE 9999
EXPOSE 9031

WORKDIR /usr/local/pingfederate-1

COPY license4j.jar /usr/local/pingfederate-1/server/default/lib/license4j.jar
COPY pingfederate.lic /usr/local/pingfederate-1/server/default/conf/pingfederate.lic

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/pingfederate-1/bin/run.sh"]
