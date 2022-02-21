MCHS_PKG_HOMEPAGE=https://github.com/jeaye/stdman
MCHS_PKG_DESCRIPTION="Formatted C++20 stdlib man pages (cppreference)"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2020.11.17
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/jeaye/stdman/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6e96634c67349e402339b1faa8f99e47f4145aa110e2ad492e00676b28bb05e2
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="man"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make() {
	# Just install manpages without building generation utility.
	:
}
