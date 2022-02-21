MCHS_PKG_HOMEPAGE=https://www.spinellis.gr/sw/dgsh/
MCHS_PKG_DESCRIPTION="The directed graph shell"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.0
MCHS_PKG_SRCURL=https://github.com/dspinellis/dgsh/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=22a7f2794e1287a46b03ce38c27a1d9349d1c66535c30e065c8783626555c76c
MCHS_PKG_BUILD_DEPENDS="check"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR=$MCHS_PKG_SRCDIR/core-tools
	MCHS_PKG_BUILDDIR=$MCHS_PKG_SRCDIR
	cd $MCHS_PKG_BUILDDIR

	sed -i -e 's/#.*$//g' src/dgsh-elf.s
	cp $MCHS_PKG_BUILDER_DIR/s_cpow.c src/

	touch ../.config
	mkdir -p m4
	autoreconf -fi
}
