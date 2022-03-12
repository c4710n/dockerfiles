FROM alpine:3.11 AS builder

RUN apk add --no-cache \
  autoconf \
  automake \
  build-base \
  clang \
  clang-static \
  gettext-dev \
  gettext-static \
  libmaxminddb-dev \
  libressl-dev \
  linux-headers \
  ncurses-dev \
  ncurses-static \
  tzdata

WORKDIR /goaccess
RUN wget -q -O - https://github.com/allinurl/goaccess/archive/v1.3.tar.gz | tar --strip 1 -xzf - && \
    autoreconf -fiv && \
    CC="clang" CFLAGS="-O3 -static" LIBS="$(pkg-config --libs openssl)" ./configure --prefix="" --enable-utf8 --with-openssl --enable-geoip=mmdb && \
    make && make DESTDIR=/dist install

FROM alpine:3.11

RUN apk add --no-cache tini nginx
COPY --from=builder /dist /

COPY /config /config/
COPY /docker-entrypoint.sh /

VOLUME /var/log/web
EXPOSE 80
ENTRYPOINT [ "/docker-entrypoint.sh" ]
