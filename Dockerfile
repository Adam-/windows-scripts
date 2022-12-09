FROM debian:buster
RUN apt-get update -qq && apt-get install -yf sudo \
  gcc-mingw-w64-i686 g++-mingw-w64-i686 binutils-mingw-w64-i686 mingw-w64-i686-dev lzip cmake wget make bzip2 build-essential m4 autopoint gettext pkg-config groff autoconf libtool vim less
WORKDIR /windows-scripts
CMD /windows-scripts/all.sh
