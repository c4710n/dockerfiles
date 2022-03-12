ARG TROJAN_VERSION=1.14.1
ARG WORK_DIR=/build

FROM alpine:3.11 AS builder

ARG TROJAN_VERSION
ARG WORK_DIR

RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev

RUN wget -O- https://github.com/trojan-gfw/trojan/archive/v${TROJAN_VERSION}.tar.gz | tar xzf - --strip-components=1 -C ${WORK_DIR} \
  && cmake . \
  && make -j $(nproc) \
  && strip -s trojan

FROM alpine:3.11

ARG WORK_DIR

RUN apk add --no-cache --virtual .rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

COPY --from=builder $WORK_DIR/trojan /usr/bin/
COPY entrypoint.sh /

EXPOSE 443
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]
