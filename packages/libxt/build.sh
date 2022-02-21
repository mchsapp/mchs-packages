# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 toolkit intrinsics library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.1
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXt-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=679cc08f1646dbd27f5e48ffe8dd49406102937109130caab02ca32c083a3d60
MCHS_PKG_DEPENDS="libice, libsm, libuuid, libx11, libxau, libxcb, libxdmcp"
MCHS_PKG_BUILD_DEPENDS="xorg-util-macros"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"

mchs_step_pre_configure() {
	export CFLAGS_FOR_BUILD=" "
	export LDFLAGS_FOR_BUILD=" "
}
