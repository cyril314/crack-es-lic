ARG VERSION
ARG JDKVER

FROM elasticsearch:${VERSION} AS Baseline

FROM eclipse-temurin:${JDKVER}-jdk-ubi9-minimal


ARG VERSION
ARG HTTP_PROXY
ARG HTTPS_PROXY
ENV VERSION=${VERSION}

WORKDIR /crack

COPY --from=Baseline /usr/share/elasticsearch/lib /usr/share/elasticsearch/lib
COPY --from=Baseline /usr/share/elasticsearch/modules/x-pack-core /usr/share/elasticsearch/modules/x-pack-core
COPY build_crack_jar.sh /crack

RUN microdnf install -y zip unzip && microdnf clean all

CMD [ "bash", "build_crack_jar.sh" ]
