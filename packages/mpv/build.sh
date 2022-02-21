MCHS_PKG_HOMEPAGE=https://mpv.io/
MCHS_PKG_DESCRIPTION="Command-line media player"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.34.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/mpv-player/mpv/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=32ded8c13b6398310fa27767378193dc1db6d78b006b70dbcbd3123a1445e746
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ffmpeg, libandroid-glob, libandroid-support, libarchive, libcaca, libiconv, liblua52, pulseaudio, openal-soft, zlib"
MCHS_PKG_RM_AFTER_INSTALL="share/icons share/applications"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR

	./bootstrap.py

	./waf configure \
		--prefix=$MCHS_PREFIX \
		--disable-gl \
		--disable-jpeg \
		--disable-lcms2 \
		--enable-libarchive \
		--enable-libmpv-shared \
		--enable-lua \
		--enable-pulse \
		--enable-openal \
		--enable-caca \
		--disable-alsa \
		--disable-x11

	./waf -v install

	# Use opensles audio out be default:
	mkdir -p $MCHS_PREFIX/etc/mpv
	cp $MCHS_PKG_BUILDER_DIR/mpv.conf $MCHS_PREFIX/etc/mpv/mpv.conf
}
