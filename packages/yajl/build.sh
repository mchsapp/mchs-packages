MCHS_PKG_HOMEPAGE=https://lloyd.github.io/yajl/
MCHS_PKG_DESCRIPTION="Yet Another JSON Library"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.0
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://github.com/lloyd/yajl/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a
MCHS_PKG_BREAKS="yajl-dev"
MCHS_PKG_REPLACES="yajl-dev"
MCHS_PKG_FORCE_CMAKE=true

mchs_step_post_make_install() {
	# Fix location of 'yajl.pc'.
	mkdir -p "${MCHS_PREFIX}"/lib/pkgconfig
	mv -f \
		"${MCHS_PREFIX}"/share/pkgconfig/yajl.pc \
		"${MCHS_PREFIX}"/lib/pkgconfig/yajl.pc
}
