#!/bin/bash

set -e

MAXMIND_VERSION="1.3.2"

. mingw.sh

if [ ! -f GeoIP-$GEOIP_VERSION.tar.gz ] ; then
	wget https://github.com/maxmind/libmaxminddb/releases/download/$MAXMIND_VERSION/libmaxminddb-$MAXMIND_VERSION.tar.gz
fi
rm -rf libmaxminddb-$MAXMIND_VERSION
tar zxf libmaxminddb-$MAXMIND_VERSION.tar.gz
rm -rf maxminddb

pushd libmaxminddb-$MAXMIND_VERSION

./configure --prefix=$PREFIX/maxminddb --host=$TOOLCHAINPREFIX --enable-shared --disable-static --disable-tests
make LDFLAGS="-no-undefined -lws2_32"
make install

popd

pushd maxminddb/lib
echo EXPORTS > libmaxminddb.def
$TOOLCHAINPREFIX-nm libmaxminddb.dll.a | grep ' T _' | sed 's/.* T _//' >> libmaxminddb.def
popd

