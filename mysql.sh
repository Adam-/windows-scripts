
MYSQL_VERSION="6.1.5"

. vars.sh

if [ ! -f mysql-connector-c-$MYSQL_VERSION-src.tar.gz ] ; then
	wget http://dev.mysql.com/get/Downloads/Connector-C/mysql-connector-c-$MYSQL_VERSION-src.tar.gz
fi
rm -rf mysql mysql-native mysql-windows

# native build
mkdir mysql-native
pushd mysql-native

tar zxf ../mysql-connector-c-$MYSQL_VERSION-src.tar.gz
cd mysql-connector-c-$MYSQL_VERSION-src

cp ../../Toolchan-mingw.cmake .
patch -p1 < ../../mysql.diff

mkdir build
cd build

cmake ..
make

popd

# cross compile
mkdir mysql-windows
pushd mysql-windows

tar zxf ../mysql-connector-c-$MYSQL_VERSION-src.tar.gz
cd mysql-connector-c-$MYSQL_VERSION-src

cp ../../Toolchan-mingw.cmake .
patch -p1 < ../../mysql.diff

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX/mysql -DTOOLCHAIN_PREFIX=$TOOLCHAINPREFIX  -DCMAKE_TOOLCHAIN_FILE=../Toolchan-mingw.cmake -DIMPORT_EXECUTABLES=../../../mysql-native/mysql-connector-c-$MYSQL_VERSION-src/build/ImportExecutables.cmake

make
make install

popd

pushd mysql/lib
ln -s liblibmysql.dll libmysql.dll
popd

