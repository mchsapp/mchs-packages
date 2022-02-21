MCHS_PKG_HOMEPAGE=http://www.thc.org/
MCHS_PKG_DESCRIPTION="Secure file, disk, swap, memory erasure utilities"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=http://deb.debian.org/debian/pool/main/s/secure-delete/secure-delete_$MCHS_PKG_VERSION.orig.tar.gz
MCHS_PKG_SHA256=78af201401e6dc159298cb5430c28996a8bdc278391d942d1fe454534540ee3c
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	make -j1 CC="$CC"
}

mchs_step_make_install() {
	make install INSTALL_DIR="$MCHS_PREFIX/bin"
	install -Dm600 -t "$MCHS_PREFIX"/share/man/man1 sfill.1 smem.1 srm.1 sswap.1
}
