
OPENLDAP_VERSION="2.4.39"

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

echo EXPORTS > libldap.def
$TOOLCHAINPREFIX-nm libldap.dll.a | grep ' T _' | sed 's/.* T _//' >> libldap.def
$TOOLCHAINPREFIX-dlltool --def libldap.def --dllname libldap.dll --output-lib libldap.lib

echo EXPORTS > liblber.def
$TOOLCHAINPREFIX-nm liblber.dll.a | grep ' T _' | sed 's/.* T _//' >> liblber.def
$TOOLCHAINPREFIX-dlltool --def liblber.def --dllname liblber.dll --output-lib liblber.lib

popd

