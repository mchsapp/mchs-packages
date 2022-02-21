MCHS_PKG_HOMEPAGE=https://github.com/gflags/gflags
MCHS_PKG_DESCRIPTION="A C++ library that implements commandline flags processing"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="COPYING.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2.2
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://github.com/gflags/gflags/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=34af2f15cf7367513b352bdcd2493ab14ce43692d2dcd9dfc499492966c64dcf
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BREAKS="gflags-dev"
MCHS_PKG_REPLACES="gflags-dev"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=ON
-DBUILD_gflags_LIBS=ON
-DINSTALL_HEADERS=ON
"

mchs_step_post_make_install() {
	#Any old packages using the library name of libgflags
	ln -sfr "$MCHS_PREFIX"/lib/pkgconfig/gflags.pc \
		"$MCHS_PREFIX"/lib/pkgconfig/libgflags.pc
}
