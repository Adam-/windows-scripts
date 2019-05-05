#!/bin/bash

set -e

GEOIP_VERSION="1.6.9"

. mingw.sh

if [ ! -f GeoIP-$GEOIP_VERSION.tar.gz ] ; then
	wget https://github.com/maxmind/geoip-api-c/releases/download/v$GEOIP_VERSION/GeoIP-$GEOIP_VERSION.tar.gz
fi
rm -rf GeoIP-$GEOIP_VERSION
tar zxf GeoIP-$GEOIP_VERSION.tar.gz
rm -rf geoip

pushd GeoIP-$GEOIP_VERSION


patch -p1 < ../geoip.diff
LDFLAGS="-lws2_32" ./configure --prefix=$PREFIX/geoip --host=$TOOLCHAINPREFIX --enable-shared --disable-static
make
make install

popd

pushd geoip/bin
ln -s libGeoIP-1.dll GeoIP.dll
popd

pushd geoip/lib

echo EXPORTS > GeoIP.def
$TOOLCHAINPREFIX-nm libGeoIP.dll.a | grep ' T _' | sed 's/.* T _//' >> GeoIP.def

popd

