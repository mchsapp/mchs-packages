MCHS_PKG_HOMEPAGE=https://git.kernel.org/cgit/devel/pahole/pahole.git/
MCHS_PKG_DESCRIPTION="Pahole and other DWARF utils"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.22
MCHS_PKG_SRCURL=http://fedorapeople.org/~acme/dwarves/dwarves-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=8bcba48be39da2868142440dc2ee7f1d7b99ffec8095e3a1afb280dc1a7c63df
MCHS_PKG_DEPENDS="argp, libdw, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-D__LIB=lib"

mchs_step_pre_configure() {
	cp $MCHS_PKG_BUILDER_DIR/obstack.h "$MCHS_PKG_SRCDIR"/
}
