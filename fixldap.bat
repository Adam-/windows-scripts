@echo off
pushd %CD%
cd openldap\lib
lib /machine:x86 /def:liblber.def
lib /machine:x86 /def:libldap_r.def
popd
