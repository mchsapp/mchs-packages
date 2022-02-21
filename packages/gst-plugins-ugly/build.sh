MCHS_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
MCHS_PKG_DESCRIPTION="GStreamer Ugly Plug-ins"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.19.3
MCHS_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=d49a10a9e87c554f2630527a5d2f924c0f55de4300106e80341fe8f9737c06e9
MCHS_PKG_DEPENDS="gst-plugins-base, libx264"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=disabled
"
