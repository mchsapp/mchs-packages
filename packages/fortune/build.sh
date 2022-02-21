MCHS_PKG_HOMEPAGE=https://www.fefe.de/fortune/
MCHS_PKG_DESCRIPTION="Revealer of fortunes"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://dl.fefe.de/fortune-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=cbb246a500366db39ce035632eb4954e09f1e03b28f2c4688864bfa8661b236a

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR
	$CC $CFLAGS $LDFLAGS fortune.c -o $MCHS_PREFIX/bin/fortune
	mkdir -p $MCHS_PREFIX/share/man/man6
	cp debian/fortune.6 $MCHS_PREFIX/share/man/man6/

	local TARFILE=$MCHS_PKG_CACHEDIR/f.tar.gz
	mchs_download \
		http://http.debian.net/debian/pool/main/f/fortune-mod/fortune-mod_1.99.1.orig.tar.gz \
		$TARFILE \
		fc51aee1f73c936c885f4e0f8b6b48f4f68103e3896eaddc6a45d2b71e14eace

	cd $MCHS_PKG_TMPDIR
	mkdir datfiles
	cd datfiles

	tar xf $TARFILE
	cd fortune-mod-1.99.1/datfiles

	rm -Rf html off Makefile
	mkdir -p $MCHS_PREFIX/share/games/fortunes
	cp * $MCHS_PREFIX/share/games/fortunes
}
