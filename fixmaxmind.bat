@echo off
pushd %CD%
cd maxminddb\lib
lib /machine:x86 /def:libmaxminddb.def
popd
