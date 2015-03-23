
OPENLDAP_VERSION="2.4.40"

. mingw.sh

if [ ! -f openldap-$OPENLDAP_VERSION.tgz ] ; then
	wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-$OPENLDAP_VERSION.tgz
fi
rm -rf openldap-$OPENLDAP_VERSION
tar zxf openldap-$OPENLDAP_VERSION.tgz
rm -rf openldap

pushd openldap-$OPENLDAP_VERSION

export CFLAGS="-I$TOOLCHAINPREFIX/include/ -I$PREFIX/pcre/include -I$PREFIX/openssl/include"
export LDFLAGS="-L$PREFIX/pcre/lib -L$PREFIX/openssl/lib"
export LIBS="-lregex"
patch -p1 < ../openldap.diff
./configure --target=mingw32 --host=$TOOLCHAINPREFIX --prefix=$PREFIX/openldap --disable-bdb --disable-hdb --disable-mdb --enable-shared
make
make install

popd

pushd openldap/lib

echo EXPORTS > libldap_r.def
$TOOLCHAINPREFIX-nm libldap_r.dll.a | grep ' T _' | sed 's/.* T _//' >> libldap_r.def

echo EXPORTS > liblber.def
$TOOLCHAINPREFIX-nm liblber.dll.a | grep ' T _' | sed 's/.* T _//' >> liblber.def

popd

