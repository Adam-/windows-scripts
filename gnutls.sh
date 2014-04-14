#!/bin/bash

GNUTLS_VERSION="3.2.13"

. mingw.sh

if [ ! -f gnutls-$GNUTLS_VERSION.tar.lz ] ; then
	wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.2/gnutls-$GNUTLS_VERSION.tar.lz
fi
rm -rf gnutls-$GNUTLS_VERSION
tar --lzip -xf gnutls-$GNUTLS_VERSION.tar.lz
rm -rf gnutls

pushd gnutls-$GNUTLS_VERSION


export CXXFLAGS="-I $PREFIX/gmp/include -I $PREFIX/nettle/include"
export CFLAGS="-I $PREFIX/gmp/include -I $PREFIX/nettle/include"
export LDFLAGS="-L$PREFIX/gmp/lib -L$PREFIX/nettle/lib -lgmp -lhogweed -lnettle"
patch -p1 < ../gnutls.diff
./configure --prefix=$PREFIX/gnutls --host=$TOOLCHAINPREFIX --enable-shared --disable-static
make
make install


popd

