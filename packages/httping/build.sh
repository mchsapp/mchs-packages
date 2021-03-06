MCHS_PKG_HOMEPAGE=https://www.vanheusden.com/httping/
MCHS_PKG_DESCRIPTION="ping-like program for http-requests"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.5
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://fossies.org/linux/www/httping-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=3e895a0a6d7bd79de25a255a1376d4da88eb09c34efdd0476ab5a907e75bfaf8
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="fftw, libandroid-support, ncurses, openssl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-fftw3 --with-ncurses --with-openssl"
