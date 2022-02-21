# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X transport library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.0
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/xtrans-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=377c4491593c417946efcd2c7600d1e62639f7a8bbca391887e2c4679807d773
MCHS_PKG_NO_DEVELSPLIT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_post_make_install() {
	mkdir -p ${MCHS_PREFIX}/lib/pkgconfig
	mv ${MCHS_PREFIX}/share/pkgconfig/xtrans.pc ${MCHS_PREFIX}/lib/pkgconfig
}
