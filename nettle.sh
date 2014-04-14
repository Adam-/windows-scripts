#!/bin/bash

NETTLE_VERSION="2.7.1"

. mingw.sh

if [ ! -f nettle-$NETTLE_VERSION.tar.gz ] ; then
	wget http://www.lysator.liu.se/~nisse/archive/nettle-$NETTLE_VERSION.tar.gz
fi
rm -rf nettle-$NETTLE_VERSION
tar zxf nettle-$NETTLE_VERSION.tar.gz
rm -rf nettle

pushd nettle-$NETTLE_VERSION

patch -p1 < ../nettle.diff
export CFLAGS="-I $PREFIX/gmp/include"
export CXXFLAGS="-I $PREFIX/gmp/include"
export LDFLAGS="-L $PREFIX/gmp/lib -lgmp"
./configure --host=$TOOLCHAINPREFIX --prefix=$PREFIX/nettle --enable-shared --disable-static
make
make install

popd

pushd nettle/lib
ln -s libnettle.dll.a libnettle.lib
ln -s libhogweed.dll.a libhogweed.lib
popd

