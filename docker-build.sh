#!/bin/bash

set -e

docker build -t windows-scripts .

docker run \
	-v `pwd`:/windows-scripts \
	-u `id -u`:`id -g` \
	-it windows-scripts

