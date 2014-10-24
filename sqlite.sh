#!/bin/bash

SQLITE_VERSION="3080700"

. mingw.sh

if [ ! -f sqlite-autoconf-$SQLITE_VERSION.tar.gz ] ; then
	wget http://sqlite.org/2014/sqlite-autoconf-$SQLITE_VERSION.tar.gz
fi
rm -rf sqlite-autoconf-$SQLITE_VERSION
tar zxf sqlite-autoconf-$SQLITE_VERSION.tar.gz
rm -rf sqlite

pushd sqlite-autoconf-$SQLITE_VERSION

./configure --prefix=$PREFIX/sqlite --host=$TOOLCHAINPREFIX --enable-shared --disable-static
make
make install

popd

pushd sqlite/lib

echo LIBRARY libsqlite3-0 > sqlite3.def
echo EXPORTS >> sqlite3.def
$TOOLCHAINPREFIX-nm libsqlite3.dll.a | grep ' T _' | sed 's/.* T _//' >> sqlite3.def

popd

