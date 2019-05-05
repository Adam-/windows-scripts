#!/bin/bash

set -e

./openssl.sh

./gmp.sh
./nettle.sh
./p11-kit.sh
./gnutls.sh

./pcre.sh
./openldap.sh

./geoip.sh
./maxminddb.sh

./sqlite.sh

./libiconv.sh
./gettext.sh

#./mysql.sh

./strip.sh

tar zcfh windows-libs.tar.gz gmp nettle p11-kit gnutls pcre openldap openssl geoip maxminddb sqlite libiconv gettext *.bat
