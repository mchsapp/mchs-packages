MCHS_PKG_HOMEPAGE=http://nginx.localdomain.pl/wiki/FcgiWrap
MCHS_PKG_DESCRIPTION="A simple server for running CGI applications over FastCGI"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_VERSION=1.1.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/gnosek/fcgiwrap/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=4c7de0db2634c38297d5fcef61ab4a3e21856dd7247d49c33d9b19542bd1c61f
MCHS_PKG_DEPENDS="fcgi"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--mandir=/share/man"

mchs_step_pre_configure() {
	CFLAGS+=" -Wno-error=implicit-fallthrough"
	autoreconf -i
}
