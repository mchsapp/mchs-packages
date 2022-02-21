MCHS_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
MCHS_PKG_DESCRIPTION="Library for reading information from media files"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_LICENSE_FILE="../../../LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=21.09
MCHS_PKG_SRCURL=https://mediaarea.net/download/source/libmediainfo/${MCHS_PKG_VERSION}/libmediainfo_${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9331e9bc04bfc1d46bb8615723715ceabdf936f90d478691ae2eabf6a26c1d40
MCHS_PKG_DEPENDS="libcurl, libzen, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-shared --enable-static --with-libcurl"

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR="${MCHS_PKG_SRCDIR}/Project/GNU/Library"
	MCHS_PKG_BUILDDIR="${MCHS_PKG_SRCDIR}"
	cd "${MCHS_PKG_SRCDIR}"
	./autogen.sh
}

mchs_step_post_make_install() {
	ln -sf "${MCHS_PREFIX}/lib/libmediainfo.so" "${MCHS_PREFIX}/lib/libmediainfo.so.0"
	ln -sf "${MCHS_PREFIX}/lib/libmediainfo.so" "${MCHS_PREFIX}/lib/libmediainfo.so.0.0"
}
