#!/bin/bash

SQLITE_VERSION="3080403"

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
ln -s libsqlite3.dll.a sqlite3.lib
popd

