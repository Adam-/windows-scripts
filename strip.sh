#!/bin/bash

$STRIP `find $PREFIX -type f \( -name "*.dll" -o -name "*.exe" \)`
