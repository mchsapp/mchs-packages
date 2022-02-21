MCHS_PKG_HOMEPAGE=https://github.com/ajeetdsouza/zoxide
MCHS_PKG_DESCRIPTION="A faster way to navigate your filesystem"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.0
MCHS_PKG_SRCURL=https://github.com/ajeetdsouza/zoxide/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=111c5f1cd92b1cb54e2f0a801003098a601c653ec5a378f3d0ea1c9659854477
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm -f ./Makefile
}

mchs_step_post_make_install() {
	# Install man page:
	mkdir -p $MCHS_PREFIX/share/man/man1/
	cp $MCHS_PKG_SRCDIR/man/* $MCHS_PREFIX/share/man/man1/
}
