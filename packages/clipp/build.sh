MCHS_PKG_HOMEPAGE=https://github.com/muellan/clipp
MCHS_PKG_DESCRIPTION="Command line interfaces for modern C++"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/muellan/clipp/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=73da8e3d354fececdea99f7deb79d0343647349563ace3eafb7f4cca6e86e90b
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	install -Dm600 -t $MCHS_PREFIX/include include/clipp.h
}
