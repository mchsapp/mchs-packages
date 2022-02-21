MCHS_PKG_HOMEPAGE=https://github.com/hanslub42/rlwrap
MCHS_PKG_DESCRIPTION="Wrapper using readline to enable editing of keyboard input for commands"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.45.2
MCHS_PKG_SRCURL=https://fossies.org/linux/privat/rlwrap-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=feb49c4ffa79f78d2439b4ffa933c77eed57eeb614ab84d967b8d692e0f6beb1
MCHS_PKG_DEPENDS="ncurses, readline"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_grantpt=yes
ac_cv_func_unlockpt=yes
ac_cv_lib_util_openpty=no
ptyttylib_cv_ptys=STREAMS
"

mchs_step_pre_configure() {
	autoreconf -vfi
}
