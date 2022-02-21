MCHS_PKG_HOMEPAGE=http://sophia.systems/
MCHS_PKG_DESCRIPTION="Advanced transactional MVCC key-value/row storage library"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2
MCHS_PKG_SRCURL=https://github.com/pmwkaa/sophia.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	install -Dm600 -t $MCHS_PREFIX/lib libsophia.a
	install -Dm600 -t $MCHS_PREFIX/lib libsophia.so.2.2.0
	ln -sfT libsophia.so.2.2.0 $MCHS_PREFIX/lib/libsophia.so.2.2
	ln -sfT libsophia.so.2.2.0 $MCHS_PREFIX/lib/libsophia.so
}
