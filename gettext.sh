#!/bin/bash

GETTEXT_VERSION="0.18.3.2"

. mingw.sh

if [ ! -f gettext-$GETTEXT_VERSION.tar.gz ] ; then
	wget http://ftp.gnu.org/pub/gnu/gettext/gettext-$GETTEXT_VERSION.tar.gz
fi
rm -rf gettext-$GETTEXT_VERSION
tar zxf gettext-$GETTEXT_VERSION.tar.gz
rm -rf gettext

pushd gettext-$GETTEXT_VERSION

CXXFLAGS="-O2" CFLAGS="-O2 -I $PREFIX/libiconv/include" LDFLAGS="-L$PREFIX/libiconv/lib -liconv" ./configure --prefix=$PREFIX/gettext --host=$TOOLCHAINPREFIX --enable-shared --disable-static --enable-relocatable --enable-threads=win32
make
make install

popd

