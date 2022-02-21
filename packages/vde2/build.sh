MCHS_PKG_HOMEPAGE=https://github.com/virtualsquare/vde-2
MCHS_PKG_DESCRIPTION="Virtual Distributed Ethernet for emulators like qemu"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="COPYING, COPYING.libvdeplug, COPYING.slirpvde"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/vde/vde2-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=cbea9b7e03097f87a6b5e98b07890d2275848f1fe4b9fcda77b8994148bc9542
MCHS_PKG_DEPENDS="libpcap,libtool , openssl, libc++"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-python"


mchs_step_pre_configure() {
	autoreconf --install
	CFLAGS+=" -Dindex=strchr -Drindex=strrchr"
}
