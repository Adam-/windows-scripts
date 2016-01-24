#!/bin/bash

LIBTASN1_VERSION="4.7"

. mingw.sh

if [ ! -f libtasn1-$LIBTASN1_VERSION.tar.gz ] ; then
	wget http://ftp.gnu.org/gnu/libtasn1/libtasn1-$LIBTASN1_VERSION.tar.gz
fi
rm -rf libtasn1 libtasn1-$LIBTASN1_VERSION
tar zxf libtasn1-$LIBTASN1_VERSION.tar.gz

pushd libtasn1-$LIBTASN1_VERSION

./configure --host=$TOOLCHAINPREFIX --prefix=$PREFIX/libtasn1 --enable-shared --disable-static
make
make install

popd

