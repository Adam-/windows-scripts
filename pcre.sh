#!/bin/bash

PCRE_VERSION="8.35"

. mingw.sh

if [ ! -f pcre-$PCRE_VERSION.tar.gz ] ; then
	wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$PCRE_VERSION.tar.gz
fi
rm -rf pcre-$PCRE_VERSION
tar zxf pcre-$PCRE_VERSION.tar.gz
rm -rf pcre

pushd pcre-$PCRE_VERSION

./configure --host=$TOOLCHAINPREFIX --prefix=$PREFIX/pcre --enable-shared --disable-static
make
make install

popd

pushd pcre/include
ln -s pcreposix.h regex.h
popd

pushd pcre/lib
ln -s libpcreposix.dll.a regex.lib
ln -s libpcre.dll.a libpcre.lib

# for libtool to find in OpenLDAP
ln -s libpcreposix.dll.a libregex.a
popd
