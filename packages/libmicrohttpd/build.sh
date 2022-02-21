MCHS_PKG_HOMEPAGE=http://www.gnu.org/software/libmicrohttpd/
MCHS_PKG_DESCRIPTION="A small C library that is supposed to make it easy to run an HTTP server as part of another application"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.73
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=a37b2f1b88fd1bfe74109586be463a434d34e773530fc2a74364cfcf734c032e
MCHS_PKG_DEPENDS="libgnutls"
MCHS_PKG_BREAKS="libmicrohttpd-dev"
MCHS_PKG_REPLACES="libmicrohttpd-dev"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-examples
--enable-curl
--enable-https
--enable-largefile
--enable-messages"
