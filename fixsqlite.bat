@echo off
pushd %CD%
cd sqlite\lib
lib /machine:x86 /def:sqlite3.def
popd
