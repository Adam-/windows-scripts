#!/bin/bash

. mingw.sh

$STRIP `find $PREFIX -type f \( -name "*.dll" -o -name "*.exe" \)`
