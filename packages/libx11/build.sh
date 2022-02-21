# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 client-side library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libX11-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=1cfa35e37aaabbe4792e9bb690468efefbfbf6b147d9c69d6f90d13c3092ea6c
MCHS_PKG_DEPENDS="libandroid-shmem, libandroid-support, libxcb"
MCHS_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros, xtrans"
MCHS_PKG_RECOMMENDS="xorg-xauth"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"

mchs_step_post_make_install() {
	ln -sfr "${MCHS_PREFIX}/lib/libX11.so" "${MCHS_PREFIX}/lib/libX11.so.6"
}
