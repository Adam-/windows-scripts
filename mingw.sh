#!/bin/sh

. vars.sh

export CC=$TOOLCHAINPREFIX-gcc
export CXX=$TOOLCHAINPREFIX-g++
export RANLIB=$TOOLCHAINPREFIX-ranlib
export WINDRES=$TOOLCHAINPREFIX-windres
export DLLTOOL=$TOOLCHAINPREFIX-dlltool
export STRIP=$TOOLCHAINPREFIX-strip

