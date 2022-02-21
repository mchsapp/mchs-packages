MCHS_PKG_HOMEPAGE=http://libvterm.sourceforge.net/
MCHS_PKG_DESCRIPTION="Terminal emulator library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
# libvterm does not do releases, take a specific commit for now:
MCHS_PKG_VERSION=19.09.17
MCHS_PKG_REVISION=1
_COMMIT=fcbccd3c79bfa811800fea24db3a77384941cb70
MCHS_PKG_SRCURL=https://github.com/neovim/libvterm/archive/$_COMMIT.zip
MCHS_PKG_SHA256=a20ebb18f37dccc685d8518147a0db78280582138ebc76e2635830cd93572bde
MCHS_PKG_BREAKS="libvterm-dev"
MCHS_PKG_REPLACES="libvterm-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	make src/encoding/DECdrawing.inc src/encoding/uk.inc
}

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR/src
	$CC -std=c99 -shared -fPIC $LDFLAGS -o $MCHS_PREFIX/lib/libvterm.so *.c -I../include -I.
	cp ../include/*.h $MCHS_PREFIX/include/
}
