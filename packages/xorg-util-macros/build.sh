# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X.Org Autotools macros"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.19.3
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/util/util-macros-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=0f812e6e9d2786ba8f54b960ee563c0663ddbe2434bf24ff193f5feab1f31971
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_post_make_install() {
	mkdir -p ${MCHS_PREFIX}/lib/pkgconfig
	mv ${MCHS_PREFIX}/share/pkgconfig/xorg-macros.pc ${MCHS_PREFIX}/lib/pkgconfig/
}
