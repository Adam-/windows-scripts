@echo off
pushd %CD%
cd gnutls\bin
lib /machine:x86 /def:..\lib\libgnutls-30.def
move libgnutls-30.lib ..\lib
popd
