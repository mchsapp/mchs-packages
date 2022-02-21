MCHS_PKG_HOMEPAGE=https://github.com/Xfennec/progress
MCHS_PKG_DESCRIPTION="Linux tool to show progress for cp, mv, dd and more"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.16
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/Xfennec/progress/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=59944ee35f8ae6d62ed4f9b643eee2ae6d03825da288d9779dc43de41164c834
MCHS_PKG_DEPENDS="libandroid-wordexp, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-wordexp"
}
