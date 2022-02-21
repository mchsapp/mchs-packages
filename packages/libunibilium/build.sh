MCHS_PKG_HOMEPAGE=https://github.com/neovim/unibilium
MCHS_PKG_DESCRIPTION="Terminfo parsing library"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.1
MCHS_PKG_SRCURL=https://github.com/neovim/unibilium/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6f0ee21c8605340cfbb458cbd195b4d074e6d16dd0c0e12f2627ca773f3cabf1
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="libunibilium-dev"
MCHS_PKG_REPLACES="libunibilium-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm -f CMakeLists.txt
}

mchs_step_make() {
	return
}

mchs_step_make_install() {
	CFLAGS+=" -DTERMINFO_DIRS=\"$MCHS_PREFIX/share/terminfo/\""
	$CC $CFLAGS -c -fPIC unibilium.c -o unibilium.o
	$CC $CFLAGS -c -fPIC uninames.c -o uninames.o
	$CC $CFLAGS -c -fPIC uniutil.c -o uniutil.o
	$CC -shared -fPIC $LDFLAGS -o $MCHS_PREFIX/lib/libunibilium.so unibilium.o uninames.o uniutil.o
	cp unibilium.h $MCHS_PREFIX/include/

	mkdir -p $PKG_CONFIG_LIBDIR
	sed "s|@VERSION@|$MCHS_PKG_VERSION|" unibilium.pc.in | \
		sed "s|@INCDIR@|$MCHS_PREFIX/include|" | \
		sed "s|@LIBDIR@|$MCHS_PREFIX/lib|" > \
		$PKG_CONFIG_LIBDIR/unibilium.pc
}
