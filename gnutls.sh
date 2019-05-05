#!/bin/bash

set -e

GNUTLS_VERSION="3.5.16"

. mingw.sh

if [ ! -f gnutls-$GNUTLS_VERSION.tar.xz ] ; then
	wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.5/gnutls-$GNUTLS_VERSION.tar.xz
fi
rm -rf gnutls gnutls-$GNUTLS_VERSION
tar -xf gnutls-$GNUTLS_VERSION.tar.xz

pushd gnutls-$GNUTLS_VERSION

patch -p1 < ../gnutls.diff
LDFLAGS="-L$PREFIX/gmp/lib" \
GMP_CFLAGS="-I$PREFIX/gmp/include" \
GMP_LIBS="-lgmp" \
PKG_CONFIG_PATH="$PREFIX/nettle/lib/pkgconfig:$PREFIX/p11-kit/lib/pkgconfig" \
./configure --prefix=$PREFIX/gnutls --host=$TOOLCHAINPREFIX --enable-shared --disable-static --disable-cxx --with-included-libtasn1 --with-included-unistring
make
make install

popd

