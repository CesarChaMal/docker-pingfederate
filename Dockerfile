FROM adoptopenjdk/openjdk8:alpine
MAINTAINER ilanyu <lanyu19950316@gmail.com>

COPY docker-entrypoint.sh /entrypoint.sh

RUN apk add --update --no-cache ca-certificates curl bash

RUN curl -SL https://s3.amazonaws.com/pingone/public_downloads/pingfederate/9.3.1/pingfederate-9.3.1.tar.gz | tar -zxC /usr/local/ && \
    mv /usr/local/pingfederate-9.3.1/pingfederate /usr/local/pingfederate-1 && \
    rm -rf /usr/local/pingfederate-9.3.1

RUN curl -SL -o /usr/local/OAuthPlayground-4.2.zip https://github.com/ilanyu/docker-pingfederate/releases/download/kit/OAuthPlayground-4.2.zip && \
    unzip /usr/local/OAuthPlayground-4.2.zip -d /usr/local/ && \
    cp -rf /usr/local/OAuthPlayground-4.2/dist/* /usr/local/pingfederate-1/server/default/ && \
    rm -rf /usr/local/OAuthPlayground-4.2.zip && \
    rm -rf /usr/local/OAuthPlayground-4.2

RUN curl -SL -o /usr/local/GitHub-Connector-1-0.zip https://github.com/ilanyu/docker-pingfederate/releases/download/kit/GitHub-Connector-1-0.zip && \
    unzip /usr/local/GitHub-Connector-1-0.zip -d /usr/local/ && \
    cp -rf /usr/local/pf-github-connector/dist/* /usr/local/pingfederate-1/server/default/deploy/ && \
    rm -rf /usr/local/GitHub-Connector-1-0.zip && \
    rm -rf /usr/local/pf-github-connector

RUN curl -SL -o /usr/local/Evernote-Connector-2-0.zip https://github.com/ilanyu/docker-pingfederate/releases/download/kit/Evernote-Connector-2-0.zip && \
    unzip /usr/local/Evernote-Connector-2-0.zip -d /usr/local/ && \
    cp -rf /usr/local/pf-evernote-connector/dist/* /usr/local/pingfederate-1/server/default/deploy/ && \
    rm -rf /usr/local/Evernote-Connector-2-0.zip && \
    rm -rf /usr/local/pf-evernote-connector

RUN curl -SL -o /usr/local/Office365-Connector-2-2.zip https://github.com/ilanyu/docker-pingfederate/releases/download/kit/Office365-Connector-2-2.zip && \
    unzip /usr/local/Office365-Connector-2-2.zip -d /usr/local/ && \
    cp -rf /usr/local/pf-office365-connector/dist/* /usr/local/pingfederate-1/server/default/deploy/ && \
    rm -rf /usr/local/Office365-Connector-2-2.zip && \
    rm -rf /usr/local/pf-office365-connector

RUN curl -SL -o /usr/local/pf-scim-connector-1.2.zip https://github.com/ilanyu/docker-pingfederate/releases/download/kit/pf-scim-connector-1.2.zip && \
    unzip /usr/local/pf-scim-connector-1.2.zip -d /usr/local/ && \
    cp -rf /usr/local/pf-scim-connector/dist/* /usr/local/pingfederate-1/server/default/deploy/ && \
    rm -rf /usr/local/pf-scim-connector-1.2.zip && \
    rm -rf /usr/local/pf-scim-connector

RUN curl -SL -o /usr/local/pf-kerberos-token-translator-2.0.2.zip https://github.com/ilanyu/docker-pingfederate/releases/download/kit/pf-kerberos-token-translator-2.0.2.zip && \
    unzip /usr/local/pf-kerberos-token-translator-2.0.2.zip -d /usr/local/ && \
    cp -rf /usr/local/pf-kerberos-token-translator/dist/* /usr/local/pingfederate-1/server/default/deploy/ && \
    rm -rf /usr/local/pf-kerberos-token-translator-2.0.2.zip && \
    rm -rf /usr/local/pf-kerberos-token-translator

RUN chmod a+x /entrypoint.sh

EXPOSE 9999
EXPOSE 9031

WORKDIR /usr/local/pingfederate-1

COPY license4j.jar /usr/local/pingfederate-1/server/default/lib/license4j.jar
COPY pingfederate.lic /usr/local/pingfederate-1/server/default/conf/pingfederate.lic

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/pingfederate-1/bin/run.sh"]
