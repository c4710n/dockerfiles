FROM buildpack-deps:stretch

ENV VERSION 7.0.8-46

ARG BUILD_DIR=/build
ARG WORKDIR=/usr/src/app
RUN mkdir -p $BUILD_DIR
RUN mkdir -p $WORKDIR
WORKDIR /build

RUN set -x \
    && wget -qO- https://www.imagemagick.org/download/ImageMagick-$VERSION.tar.xz | tar --transform "s/^ImageMagick-$VERSION/./" -xJv \
    && ./configure --prefix=$WORKDIR --enable-shared=no --with-modules=no --enable-zero-configuration \
    && make \
    && make install
