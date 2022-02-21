MCHS_PKG_HOMEPAGE=http://goaccess.io
MCHS_PKG_DESCRIPTION="An open source real-time web log analyzer and interactive viewer"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.2
MCHS_PKG_SRCURL=https://tar.goaccess.io/goaccess-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=a0ce2f9393b2622484e469e95a809dfd52ade4d4200491e43ede1fcb52ab1c8a
MCHS_PKG_DEPENDS="ncurses, openssl"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-utf8
--with-openssl"
