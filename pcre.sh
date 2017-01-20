#!/bin/bash

PCRE_VERSION="8.40"

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

pushd pcre/bin
ln -s libpcre-1.dll libpcre.dll
popd

pushd pcre/lib
# for libtool to find in OpenLDAP
ln -s libpcreposix.dll.a libregex.a
ln -s libpcreposix-0.dll libregex.a

echo EXPORTS > libpcre.def
$TOOLCHAINPREFIX-nm libpcre.dll.a | grep ' T _' | sed 's/.* T _//' >> libpcre.def
echo pcre_free >> libpcre.def

popd
