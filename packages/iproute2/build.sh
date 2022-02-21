MCHS_PKG_HOMEPAGE=https://wiki.linuxfoundation.org/networking/iproute2
MCHS_PKG_DESCRIPTION="Utilities for controlling networking"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.15.0
MCHS_PKG_SRCURL=https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=38e3e4a5f9a7f5575c015027a10df097c149111eeb739993128e5b2b35b291ff
MCHS_PKG_DEPENDS="libandroid-glob, libandroid-support"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" -fPIC"
	LDFLAGS+=" -landroid-glob"
}
