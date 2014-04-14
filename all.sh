#!/bin/bash

./openssl.sh

./gmp.sh
./nettle.sh
./gnutls.sh

./pcre.sh
./openldap.sh

./geoip.sh

./sqlite.sh

tar zcfh inspircd-libs.tar.gz gmp nettle gnutls fixgnutls.bat pcre openldap openssl fixopenssl.bat geoip sqlite
