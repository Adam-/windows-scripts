#!/bin/bash

./openssl.sh

./gmp.sh
./nettle.sh
./libffi.sh
./libtasn1.sh
./p11-kit.sh
./gnutls.sh

./pcre.sh
./openldap.sh

./geoip.sh

./sqlite.sh

./libiconv.sh
./gettext.sh

#./mysql.sh

./strip.sh

tar zcfh windows-libs.tar.gz gmp nettle libffi libtasn1 p11-kit gnutls pcre openldap openssl geoip sqlite libiconv gettext *.bat
