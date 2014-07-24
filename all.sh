#!/bin/bash

./openssl.sh

./gmp.sh
./nettle.sh
./gnutls.sh

./pcre.sh
./openldap.sh

./geoip.sh

./sqlite.sh

./libiconv.sh
./gettext.sh

./mysql.sh

./strip.sh

tar zcfh windows-libs.tar.gz gmp nettle gnutls pcre openldap openssl geoip sqlite libiconv gettext mysql
