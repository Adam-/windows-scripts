#!/bin/bash

P11KIT_VERSION="0.23.2"

. mingw.sh

if [ ! -f p11-kit-$P11KIT_VERSION.tar.gz ] ; then
	wget http://p11-glue.freedesktop.org/releases/p11-kit-$P11KIT_VERSION.tar.gz
fi
rm -rf p11-kit p11-kit-$P11KIT_VERSION
tar zxf p11-kit-$P11KIT_VERSION.tar.gz

pushd p11-kit-$P11KIT_VERSION

LDFLAGS=-lws2_32 \
PKG_CONFIG_PATH=$PREFIX/libffi/lib/pkgconfig/:$PREFIX/libtasn1/lib/pkgconfig \
./configure --host=$TOOLCHAINPREFIX --prefix=$PREFIX/p11-kit --enable-shared --disable-static
make
make install

popd

