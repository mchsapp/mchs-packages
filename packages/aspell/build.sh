MCHS_PKG_HOMEPAGE=http://aspell.net
MCHS_PKG_DESCRIPTION="A free and open source spell checker designed to replace Ispell"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.60.8
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/aspell-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f9b77e515334a751b2e60daab5db23499e26c9209f5e7b7443b05235ad0226f2
# To use the same compiled dictionaries on every platform:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-32-bit-hash-fun"
