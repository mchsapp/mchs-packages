MCHS_PKG_HOMEPAGE=http://tobold.org/article/rc
MCHS_PKG_DESCRIPTION="An alternative implementation of the plan 9 rc shell"
MCHS_PKG_LICENSE="ZLIB"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.4
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://sources.voidlinux-ppc.org/rc-${MCHS_PKG_VERSION}/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0b83f8698dd8ef44ca97b25c4748c087133f53c7fff39b6b70dab65931def8b0
MCHS_PKG_DEPENDS="readline"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_setpgrp_void=yes
rc_cv_sysv_sigcld=no
"

mchs_step_host_build() {
	(cd $MCHS_PKG_SRCDIR && autoreconf -vfi)
	$MCHS_PKG_SRCDIR/configure
	make mksignal mkstatval
}

mchs_step_pre_configure() {
	autoreconf -vfi
	cp $MCHS_PKG_HOSTBUILD_DIR/{mksignal,mkstatval} $MCHS_PKG_BUILDDIR/
	touch -d 'next hour' $MCHS_PKG_BUILDDIR/{mksignal,mkstatval}
}
