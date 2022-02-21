MCHS_PKG_HOMEPAGE="http://git.linux-nfs.org/?p=steved/libtirpc.git"
MCHS_PKG_DESCRIPTION="Transport Independent RPC library"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/libtirpc/libtirpc-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=e24eb88b8ce7db3b7ca6eb80115dd1284abc5ec32a8deccfed2224fc2532b9fd
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-gssapi"

mchs_step_pre_configure() {
	aclocal
	automake
	autoconf
}
