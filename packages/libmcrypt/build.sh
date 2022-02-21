MCHS_PKG_HOMEPAGE=http://mcrypt.sourceforge.net/
MCHS_PKG_DESCRIPTION="A library which provides a uniform interface to several symmetric encryption algorithms"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.5.8
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/mcrypt/libmcrypt-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=bf2f1671f44af88e66477db0982d5ecb5116a5c767b0a0d68acb34499d41b793
MCHS_PKG_BREAKS="libmcrypt-dev"
MCHS_PKG_REPLACES="libmcrypt-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MCHS_PREFIX/share/man"
