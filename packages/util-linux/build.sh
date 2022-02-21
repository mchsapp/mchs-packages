MCHS_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Util-linux
MCHS_PKG_DESCRIPTION="Miscellaneous system utilities"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.37.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://www.kernel.org/pub/linux/utils/util-linux/v${MCHS_PKG_VERSION:0:4}/util-linux-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=6a0764c1aae7fb607ef8a6dd2c0f6c47d5e5fd27aa08820abaad9ec14e28e9d9
MCHS_PKG_DEPENDS="ncurses, libcap-ng, libcrypt, zlib"
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_BREAKS="util-linux-dev"
MCHS_PKG_REPLACES="util-linux-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_setns=yes
ac_cv_func_unshare=yes
--enable-setpriv
--disable-agetty
--disable-ctrlaltdel
--disable-eject
--disable-fdformat
--disable-ipcrm
--disable-ipcs
--disable-kill
--disable-last
--disable-libuuid
--disable-logger
--disable-mesg
--disable-nologin
--disable-pivot_root
--disable-raw
--disable-switch_root
--disable-wall
--disable-libmount
--disable-lsmem
--disable-chmem
--disable-rfkill
--disable-hwclock-cmos
"

mchs_step_pre_configure() {
	if [ $MCHS_ARCH_BITS = 64 ]; then
		#prlimit() is only available in 64-bit bionic.
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_prlimit=yes"
	fi
}
