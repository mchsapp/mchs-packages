MCHS_PKG_HOMEPAGE=https://github.com/mtoyoda/sl
MCHS_PKG_DESCRIPTION="Tool curing your bad habit of mistyping"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_VERSION=5.02
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/mtoyoda/sl/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=1e5996757f879c81f202a18ad8e982195cf51c41727d3fea4af01fdcbbb5563a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_LICENSE_FILE="LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	install sl $MCHS_PREFIX/bin/
	cp sl.1 $MCHS_PREFIX/share/man/man1
}
