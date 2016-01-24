@echo off
pushd %CD%
cd gnutls\bin
lib /machine:x86 /def:libgnutls-30.def
move libgnutls-30.lib ..\lib
popd
