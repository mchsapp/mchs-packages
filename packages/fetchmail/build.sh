MCHS_PKG_HOMEPAGE=https://www.fetchmail.info/
MCHS_PKG_DESCRIPTION="A remote-mail retrieval utility"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.4.27
MCHS_PKG_SRCURL=https://sourceforge.net/projects/fetchmail/files/branch_${MCHS_PKG_VERSION:0:3}/fetchmail-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=9e64f9e71f798cf1fe2278b84e2f5880b806527c0c0206925c086ccd179113dc
MCHS_PKG_DEPENDS="libcrypt, openssl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-ssl=$MCHS_PREFIX"

mchs_step_pre_configure() {
	export LIBS="-llog"
}
