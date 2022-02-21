MCHS_PKG_HOMEPAGE=http://0xcc.net/ttyrec/
MCHS_PKG_DESCRIPTION="Terminal recorder and player"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.8
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=http://0xcc.net/ttyrec/ttyrec-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ef5e9bf276b65bb831f9c2554cd8784bd5b4ee65353808f82b7e2aef851587ec
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" -Dset_progname=setprogname $LDFLAGS"
}

mchs_step_make_install() {
	cp ttyrec ttyplay ttytime $MCHS_PREFIX/bin
	mkdir -p $MCHS_PREFIX/share/man/man1
	cp ttyrec.1 ttyplay.1 ttytime.1 $MCHS_PREFIX/share/man/man1
}
