@echo off
pushd %CD%
cd pcre\lib
lib /machine:x86 /def:libpcre.def
popd
