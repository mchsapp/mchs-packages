MCHS_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/projects/orc.html
MCHS_PKG_DESCRIPTION="Library of Optimized Inner Loops Runtime Compiler"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.32
MCHS_PKG_SRCURL=https://github.com/GStreamer/orc/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6a7349d2ab4a73476cd4de36212e8c3c6524998081aaa04cf3a891ef792dd50f

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dorc-test=disabled
-Dtests=disabled
-Dbenchmarks=disabled
-Dexamples=disabled
-Dgtk_doc=disabled
"
