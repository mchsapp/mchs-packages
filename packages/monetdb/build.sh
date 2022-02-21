MCHS_PKG_HOMEPAGE=https://www.monetdb.org/
MCHS_PKG_DESCRIPTION="A high-performance database kernel for query-intensive applications"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=11.41.13
MCHS_PKG_SRCURL=https://www.monetdb.org/downloads/sources/archive/MonetDB-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=7738e106ac3a39bfb37feb8efa9a050a412fb332ab58c29a8aad23c01ba42197
MCHS_PKG_DEPENDS="libbz2, libcurl, libiconv, liblz4, liblzma, libpcreposix, libuuid, libxml2, netcdf-c, openssl, readline, zlib"

mchs_step_post_get_source() {
	find . -name '*.c' | xargs -n 1 sed -i \
		-e 's:"\(/tmp\):"'$MCHS_PREFIX'\1:g'
	cp $MCHS_PKG_BUILDER_DIR/sys_sem.c gdk/
}
