MCHS_PKG_HOMEPAGE=https://tdb.samba.org/
MCHS_PKG_DESCRIPTION="A trivial database system"
MCHS_PKG_LICENSE="LGPL-3.0, GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.5
MCHS_PKG_SRCURL=https://samba.org/ftp/tdb/tdb-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bcfced884f7031080998b5c4b1c5dce57567055f79417f86dba40dcde99a0e41
MCHS_PKG_DEPENDS="libbsd"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--cross-compile
--cross-answers cross-answers.txt
--disable-python
"

mchs_step_pre_configure() {
	sed 's:@MCHS_ARCH@:'$MCHS_ARCH':g' \
		$MCHS_PKG_BUILDER_DIR/cross-answers.txt > cross-answers.txt
}

mchs_step_configure() {
	./configure \
		--prefix=$MCHS_PREFIX \
		--host=$MCHS_HOST_PLATFORM \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS
}
