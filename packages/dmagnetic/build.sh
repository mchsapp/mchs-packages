MCHS_PKG_HOMEPAGE=https://www.dettus.net/dMagnetic
MCHS_PKG_DESCRIPTION="Interpreter for classic text adventure games and interactive fiction"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.32
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://www.dettus.net/dMagnetic/dMagnetic_${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=9671b863cbb126e122923fa974806ff0e998af471c98e878c1392c20a3606206
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_GROUPS="games"

mchs_step_host_build() {
	cd $MCHS_PKG_BUILDDIR
	make -j $MCHS_MAKE_PROCESSES dMagnetic
	mv dMagnetic $MCHS_PKG_HOSTBUILD_DIR/
	make clean
}

mchs_step_post_configure() {
	# find our host-built dMagnetic
	export PATH=$MCHS_PKG_HOSTBUILD_DIR:$PATH
}

mchs_step_post_make_install() {
	sed "s%@MCHS_PREFIX@%$MCHS_PREFIX%g" \
	    $MCHS_PKG_BUILDER_DIR/magnetic-scrolls.in \
	    > $MCHS_PREFIX/bin/magnetic-scrolls
	chmod 700 $MCHS_PREFIX/bin/magnetic-scrolls
}
