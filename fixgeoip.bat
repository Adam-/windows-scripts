@echo off
pushd %CD%
cd geoip\lib
lib /machine:x86 /def:GeoIP.def
popd
