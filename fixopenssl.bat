@echo off
cd openssl\lib

lib /machine:x86 /def:ssleay32.def
lib /machine:x86 /def:libeay32.def
