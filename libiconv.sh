#!/bin/bash

set -e

LIBICONV_VERSION="1.14"

. mingw.sh

if [ ! -f libiconv-$LIBICONV_VERSION.tar.gz ] ; then
	wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-$LIBICONV_VERSION.tar.gz
fi
rm -rf libiconv-$LIBICONV_VERSION
tar zxf libiconv-$LIBICONV_VERSION.tar.gz
rm -rf libiconv

pushd libiconv-$LIBICONV_VERSION

./configure --prefix=$PREFIX/libiconv --host=$TOOLCHAINPREFIX --enable-shared --disable-static
make
make install

popd

pushd libiconv/lib

ln -s libiconv.dll.a libiconv.lib

popd

