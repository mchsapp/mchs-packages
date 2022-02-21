MCHS_PKG_HOMEPAGE=https://core.tcl.tk/expect/index
MCHS_PKG_DESCRIPTION="Tool for automating interactive terminal applications"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.45.4
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/expect/Expect/${MCHS_PKG_VERSION}/expect${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=49a7da83b0bdd9f46d04a04deec19c7767bb9a323e40c4781f89caf760b92c34
MCHS_PKG_DEPENDS="tcl"
MCHS_PKG_BREAKS="expect-dev"
MCHS_PKG_REPLACES="expect-dev"

mchs_step_pre_configure() {
	autoconf
}

mchs_step_post_make_install() {
	cd $MCHS_PREFIX/lib
	ln -f -s expect${MCHS_PKG_VERSION}/libexpect${MCHS_PKG_VERSION}.so .
}
