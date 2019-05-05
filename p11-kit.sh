#!/bin/bash

set -e

P11KIT_VERSION="0.23.2"

. mingw.sh

if [ ! -f p11-kit-$P11KIT_VERSION.tar.gz ] ; then
	wget https://github.com/p11-glue/p11-kit/archive/$P11KIT_VERSION.tar.gz -O p11-kit-$P11KIT_VERSION.tar.gz
fi
rm -rf p11-kit p11-kit-$P11KIT_VERSION
tar zxf p11-kit-$P11KIT_VERSION.tar.gz

pushd p11-kit-$P11KIT_VERSION

LDFLAGS=-lws2_32 \
./autogen.sh --host=$TOOLCHAINPREFIX --prefix=$PREFIX/p11-kit --enable-shared --disable-static --without-libffi --without-libtasn1
make
make install

popd

