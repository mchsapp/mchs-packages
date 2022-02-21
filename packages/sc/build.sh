MCHS_PKG_HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/financial/spreadsheet/!INDEX.html"
MCHS_PKG_DESCRIPTION="A vi-like spreadsheet calculator"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=7.16
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=http://www.ibiblio.org/pub/Linux/apps/financial/spreadsheet/sc-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=1997a00b6d82d189b65f6fd2a856a34992abc99e50d9ec463bbf1afb750d1765
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="SIMPLE=-DSIMPLE"

mchs_step_post_configure () {
	CFLAGS+=" -I$MCHS_PREFIX/include"
}
