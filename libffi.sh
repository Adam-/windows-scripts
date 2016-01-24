#!/bin/bash

LIBFFI_VERSION="3.2.1"

. mingw.sh

if [ ! -f libffi-$LIBFFI_VERSION.tar.gz ] ; then
	wget ftp://sourceware.org/pub/libffi/libffi-$LIBFFI_VERSION.tar.gz
fi
rm -rf libffi libffi-$LIBFFI_VERSION
tar zxf libffi-$LIBFFI_VERSION.tar.gz

pushd libffi-$LIBFFI_VERSION

./configure --host=$TOOLCHAINPREFIX --prefix=$PREFIX/libffi --enable-shared --disable-static
make
make install

popd

