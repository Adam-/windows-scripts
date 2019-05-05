#!/bin/bash

set -e

GMP_VERSION="6.0.0a"
GMP_DIR="6.0.0"

. mingw.sh

if [ ! -f gmp-$GMP_VERSION.tar.bz2 ] ; then
	wget https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.bz2
fi
rm -rf gmp-$GMP_VERSION
tar xjf gmp-$GMP_VERSION.tar.bz2
rm -rf gmp

pushd gmp-$GMP_DIR

./configure --host=$TOOLCHAINPREFIX --prefix=$PREFIX/gmp/ --enable-shared --disable-static
make
make install

popd

pushd gmp/lib
ln -s libgmp.lib gmp.lib
popd
