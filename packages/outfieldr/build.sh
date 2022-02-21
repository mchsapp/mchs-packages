MCHS_PKG_HOMEPAGE=https://gitlab.com/ve-nt/outfieldr
MCHS_PKG_DESCRIPTION="A TLDR client in Zig"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.2
MCHS_PKG_SRCURL=https://gitlab.com/ve-nt/outfieldr.git
MCHS_PKG_GIT_BRANCH=$MCHS_PKG_VERSION
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_make() {
	mchs_setup_zig
	zig build -Dtarget=$ZIG_TARGET_NAME
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin bin/tldr
}
