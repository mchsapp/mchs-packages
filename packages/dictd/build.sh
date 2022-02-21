MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/dict/
MCHS_PKG_DESCRIPTION="Online dictionary client and server"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.13.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/dict/dictd/dictd-${MCHS_PKG_VERSION}/dictd-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=eeba51af77e87bb1b166c6bc469aad463632d40fb2bdd65e6675288d8e1a81e4
MCHS_PKG_DEPENDS="libmaa, zlib"
MCHS_PKG_CONFFILES="etc/dict.conf"

mchs_step_post_make_install() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/dict.conf $MCHS_PREFIX/etc/dict.conf
}
