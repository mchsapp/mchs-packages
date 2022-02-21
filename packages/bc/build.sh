MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/bc/
MCHS_PKG_DESCRIPTION="Arbitrary precision numeric processing language"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.07.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/bc/bc-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a
MCHS_PKG_DEPENDS="readline,flex"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--infodir=$MCHS_PREFIX/share/info
--mandir=$MCHS_PREFIX/share/man
--with-readline
"

mchs_step_pre_configure() {
	cp $MCHS_PKG_HOSTBUILD_DIR/bc/libmath.h \
	   $MCHS_PKG_SRCDIR/bc/libmath.h
	touch -d "next hour" $MCHS_PKG_SRCDIR/bc/libmath.h
}
