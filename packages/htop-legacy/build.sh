MCHS_PKG_HOMEPAGE=https://hisham.hm/htop/
MCHS_PKG_DESCRIPTION="Interactive process viewer for Linux"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
# DO NOT UPDATE
MCHS_PKG_VERSION=1:2.2.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/htop-dev/htop/archive/${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=fb23275090ee5fb19266384c39c69519c8b3844b8f6444730094949c621197c0
# htop checks setlocale() return value for UTF-8 support, so use libandroid-support.
MCHS_PKG_DEPENDS="ncurses, libandroid-support"
MCHS_PKG_CONFLICTS="htop"
MCHS_PKG_REPLACES="htop"
MCHS_PKG_PROVIDES="htop"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_ncursesw6_addnwstr=yes
LIBS=-landroid-support
"

mchs_step_pre_configure() {
	./autogen.sh
	export CFLAGS+=" -fcommon"
}
