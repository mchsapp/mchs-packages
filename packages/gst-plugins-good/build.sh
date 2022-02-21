MCHS_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
MCHS_PKG_DESCRIPTION="GStreamer Good Plug-ins"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.19.3
MCHS_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=79ea32a77fa47e6596530e38113bf97c113fd95658087d9a91ffb8af47d11d07
MCHS_PKG_DEPENDS="gst-plugins-base, libandroid-shmem, libcaca, libsoup, libjpeg-turbo, libpng, libflac, libbz2, libvpx, pulseaudio, libmp3lame, gstreamer, libogg, zlib"
# pcre needed by glib. libxml2 needed by libsoup
MCHS_PKG_BUILD_DEPENDS="glib, pcre, libxml2"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dcairo=disabled
-Dexamples=disabled
-Dgdk-pixbuf=disabled
-Doss=disabled
-Doss4=disabled
-Dtests=disabled
-Dv4l2=disabled
-Daalib=disabled
"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"
}
