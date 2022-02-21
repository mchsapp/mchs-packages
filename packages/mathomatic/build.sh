MCHS_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Mathomatic
MCHS_PKG_DESCRIPTION="Simple CAS and symbolic calculator"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=16.0.5
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL="https://fossies.org/linux/misc/old/mathomatic-${MCHS_PKG_VERSION}.tar.xz"
MCHS_PKG_SHA256=7f525bdb2e13006549dd8f17906c26f926f5ac51174f02f074107c612491e05c
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="READLINE=1"
MCHS_PKG_DEPENDS="readline"
MCHS_PKG_RM_AFTER_INSTALL="share/applications/mathomatic.desktop share/pixmaps"

mchs_step_pre_configure() {
	rm $MCHS_PKG_SRCDIR/CMakeLists.txt
	CPPFLAGS+=" -DUSE_TGAMMA -DBOLD_COLOR"
}
