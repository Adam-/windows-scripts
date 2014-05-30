#!/bin/bash

. mingw.sh

$STRIP `find $PREFIX -type f -perm -u=w \( -name "*.dll" -o -name "*.exe" \)`
