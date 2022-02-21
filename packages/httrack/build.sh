MCHS_PKG_HOMEPAGE=http://www.httrack.com
MCHS_PKG_DESCRIPTION="It allows you to download a World Wide Web site from the Internet"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.49.2
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=http://mirror.httrack.com/historical/httrack-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=3477a0e5568e241c63c9899accbfcdb6aadef2812fcce0173688567b4c7d4025
MCHS_PKG_DEPENDS="libiconv, openssl, zlib"
MCHS_PKG_BREAKS="httrack-dev"
MCHS_PKG_REPLACES="httrack-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-zlib=$MCHS_PREFIX LIBS=-liconv"
MCHS_PKG_BUILD_IN_SRC=true
