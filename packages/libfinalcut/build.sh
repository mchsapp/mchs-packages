MCHS_PKG_HOMEPAGE=https://github.com/gansm/finalcut
MCHS_PKG_DESCRIPTION="A C++ class library and widget toolkit for creating a text-based user interface"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.0
MCHS_PKG_SRCURL=https://github.com/gansm/finalcut/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0bb4de87df2c466d5ba6513cadcb691a3387e60884c65c7bd158e8350f7f4829
MCHS_PKG_DEPENDS="libc++, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	autoreconf -fi
}
