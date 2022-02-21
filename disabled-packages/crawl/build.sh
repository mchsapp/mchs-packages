# Currently fails at:
# Makefile:101: recipe for target 'tiledef-dngn.h' failed
# make[1]: *** [tiledef-dngn.h] Segmentation fault (core dumped)

MCHS_PKG_HOMEPAGE=https://crawl.develz.org/
MCHS_PKG_DESCRIPTION="Roguelike adventure through dungeons filled with dangerous monsters"
MCHS_PKG_VERSION=0.17.1
MCHS_PKG_SRCURL=https://crawl.develz.org/release/stone_soup-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_EXTRA_MAKE_ARGS="V=1"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export CROSSHOST=$MCHS_HOST_PLATFORM
	MCHS_PKG_BUILDDIR=$MCHS_PKG_SRCDIR/source
}
