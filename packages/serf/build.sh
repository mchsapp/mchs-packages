MCHS_PKG_HOMEPAGE=https://serf.apache.org/
MCHS_PKG_DESCRIPTION="High performance C-based HTTP client library"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.9
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://archive.apache.org/dist/serf/serf-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=549c2d21c577a8a9c0450facb5cca809f26591f048e466552240947bdf7a87cc
MCHS_PKG_DEPENDS="apr, apr-util, openssl, libuuid, libexpat, zlib"
MCHS_PKG_BREAKS="serf-dev"
MCHS_PKG_REPLACES="serf-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	scons APR=$MCHS_PREFIX \
	      APU=$MCHS_PREFIX \
	      CC=$(command -v $CC) \
	      CFLAGS="$CFLAGS" \
	      CPPFLAGS="$CPPFLAGS -std=c11" \
	      LINKFLAGS="$LDFLAGS" \
	      OPENSSL=$MCHS_PREFIX \
	      PREFIX=$MCHS_PREFIX \
	      install
	# Avoid specifying -lcrypt:
	perl -p -i -e 's/-lcrypt //' $MCHS_PREFIX/lib/pkgconfig/serf-1.pc
}
