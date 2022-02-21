MCHS_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
MCHS_PKG_DESCRIPTION="GStreamer base plug-ins"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.19.3
MCHS_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=e277f198623a26c1b0a1e19734656392e9368bebf3677cd94262a1316a960827
MCHS_PKG_DEPENDS="gstreamer, libandroid-shmem, libjpeg-turbo, libopus, libpng, libvorbis, zlib"
MCHS_PKG_BREAKS="gst-plugins-base-dev"
MCHS_PKG_REPLACES="gst-plugins-base-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=disabled
-Dexamples=disabled
-Dpango=disabled
"

# Conflicts with Mesa.
MCHS_PKG_RM_AFTER_INSTALL="include/GL"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"
}
