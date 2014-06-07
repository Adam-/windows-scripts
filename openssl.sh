#!/bin/bash

OPENSSL_VERSION="1.0.1h"

. vars.sh

if [ ! -f openssl-$OPENSSL_VERSION.tar.gz ] ; then
	wget http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
fi
rm -rf openssl-$OPENSSL_VERSION
tar zxf openssl-$OPENSSL_VERSION.tar.gz
rm -rf openssl

pushd openssl-$OPENSSL_VERSION

./Configure --prefix=$PREFIX/openssl --cross-compile-prefix=$TOOLCHAINPREFIX- -shared mingw
make
make install

perl util/mkdef.pl ssl 32 > ssleay32.def
perl util/mkdef.pl crypto 32 > libeay32.def

sed -i 's/ssl32\t$/ssleay32\t/' ssleay32.def
sed -i 's/crypto32\t$/libeay32\t/' libeay32.def

cp ssleay32.def $PREFIX/openssl/lib
cp libeay32.def $PREFIX/openssl/lib

popd

pushd $PREFIX/openssl/lib

$TOOLCHAINPREFIX-dlltool --def ssleay32.def --dllname ssleay32.dll --output-lib ssleay32.lib
$TOOLCHAINPREFIX-dlltool --def libeay32.def --dllname libeay32.dll --output-lib libeay32.lib

popd
