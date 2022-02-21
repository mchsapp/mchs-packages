MCHS_PKG_HOMEPAGE=https://github.com/martanne/dvtm
MCHS_PKG_DESCRIPTION="Terminal tiling window manager"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/martanne/dvtm/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=496eada13d8abaa8d772279746f78b0c6fed11b560599490f3e70ebc21197bf0
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="ncurses"

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}
