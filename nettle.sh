#!/bin/bash

NETTLE_VERSION="3.1"

. mingw.sh

if [ ! -f nettle-$NETTLE_VERSION.tar.gz ] ; then
	wget https://ftp.gnu.org/gnu/nettle/nettle-$NETTLE_VERSION.tar.gz
fi
rm -rf nettle-$NETTLE_VERSION
tar zxf nettle-$NETTLE_VERSION.tar.gz
rm -rf nettle

pushd nettle-$NETTLE_VERSION

CFLAGS="-I $PREFIX/gmp/include" \
CXXFLAGS="-I $PREFIX/gmp/include" \
LDFLAGS="-L $PREFIX/gmp/lib -lgmp" \
./configure --host=$TOOLCHAINPREFIX --prefix=$PREFIX/nettle --enable-shared --disable-static
make
make install

popd

pushd nettle/lib
ln -s libnettle.dll.a libnettle.lib
ln -s libhogweed.dll.a libhogweed.lib
popd

