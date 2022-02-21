MCHS_PKG_HOMEPAGE=http://abook.sourceforge.net/
MCHS_PKG_DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6.1
MCHS_PKG_SRCURL=http://abook.sourceforge.net/devel/abook-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f0a90df8694fb34685ecdd45d97db28b88046c15c95e7b0700596028bd8bc0f9
MCHS_PKG_DEPENDS="libandroid-support, ncurses, readline"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MCHS_PREFIX/share/man"

mchs_step_pre_configure() {
	aclocal
	automake --add-missing
	autoreconf
}
