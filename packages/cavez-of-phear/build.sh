MCHS_PKG_HOMEPAGE=https://github.com/AMDmi3/cavezofphear
MCHS_PKG_DESCRIPTION="A Boulder Dash like game for consoles/terminals"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Dmitry Marakasov <amdmi3@amdmi3.ru>"
MCHS_PKG_VERSION=0.6.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/AMDmi3/cavezofphear/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=29ea76dd1a0f38904cd09e36b7205d4a4c01324d2ba28d03f15d9ae53881aa10
MCHS_PKG_DEPENDS="libandroid-support, ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DSYSTEMWIDE=ON -DWITH_MANPAGE=OFF"
MCHS_PKG_GROUPS="games"
