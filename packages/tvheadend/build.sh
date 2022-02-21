MCHS_PKG_HOMEPAGE="https://tvheadend.org/"
MCHS_PKG_DESCRIPTION="TV streaming server for Linux and Android supporting DVB-S, DVB-S2 and other formats."
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="MrAdityaAlok <dev.aditya.alok@gmail.com>"
MCHS_PKG_VERSION=4.2.8
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL="https://github.com/tvheadend/tvheadend/archive/v${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256=1aef889373d5fad2a7bd2f139156d4d5e34a64b6d38b87b868a2df415f01f7ad
MCHS_PKG_DEPENDS="libiconv, ffmpeg, libopus, libx264, libx265, libvpx, libfdk-aac, libogg, libtheora, libvorbis, pngquant"
MCHS_PKG_BUILD_DEPENDS="gettext, openssl, zlib, libdvbcsa, pcre2, dbus"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-android
--enable-pngquant
--enable-dvbcsa
--disable-libav
--disable-hdhomerun_static
--disable-ffmpeg_static
--disable-avahi
"

mchs_step_pre_configure() {
	mchs_setup_cmake

	CFLAGS=" -I$MCHS_PKG_BUILDDIR/src $CFLAGS $CPPFLAGS"

	# Arm does not support mmx and sse2 instructions, still checks return true
	if [ "${MCHS_ARCH}" = "arm" ] || [ "${MCHS_ARCH}" = "aarch64" ]; then
		patch -p1 <"${MCHS_PKG_BUILDER_DIR}/disable-mmx-sse2"
	fi
}
