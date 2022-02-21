MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/mtools/
MCHS_PKG_DESCRIPTION="Tool for manipulating FAT images."
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.0.35
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/mtools/mtools-${MCHS_PKG_VERSION}.tar.lz
MCHS_PKG_SHA256=0778c2a96cce205f1c5b702e2fe2eaacc9af7628ef28b943e1b600a3ddd85dbe
MCHS_PKG_DEPENDS="libandroid-support, libiconv"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-floppyd
ac_cv_lib_bsd_main=no
"

mchs_step_pre_configure() {
	export LIBS="-liconv"
}
