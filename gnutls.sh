#!/bin/bash

GNUTLS_VERSION="3.4.8"

. mingw.sh

if [ ! -f gnutls-$GNUTLS_VERSION.tar.xz ] ; then
	wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.4/gnutls-$GNUTLS_VERSION.tar.xz
fi
rm -rf gnutls gnutls-$GNUTLS_VERSION
tar -xf gnutls-$GNUTLS_VERSION.tar.xz

pushd gnutls-$GNUTLS_VERSION

patch -p1 < ../gnutls.diff
LDFLAGS="-L$PREFIX/gmp/lib" \
GMP_CFLAGS="-I$PREFIX/gmp/include" \
GMP_LIBS="-lgmp" \
CFLAGS="-I$PREFIX/libtasn1/include" \
PKG_CONFIG_PATH="$PREFIX/nettle/lib/pkgconfig:$PREFIX/libtasn1/lib/pkgconfig:$PREFIX/p11-kit/lib/pkgconfig" \
./configure --prefix=$PREFIX/gnutls --host=$TOOLCHAINPREFIX --enable-shared --disable-static --disable-cxx
make
make install

popd

