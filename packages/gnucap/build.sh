MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gnucap/gnucap.html
MCHS_PKG_DESCRIPTION="The Gnu Circuit Analysis Package"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_VERSION=20210107
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://gitlab.com/gnucap/gnucap/-/archive/${MCHS_PKG_VERSION}/gnucap-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d2c24a66c7e60b379727c9e9487ed1b4a3532646b3f4cc03c6a4305749e3348b
MCHS_PKG_DEPENDS="libc++, readline"
MCHS_PKG_BREAKS="gnucap-dev"
MCHS_PKG_REPLACES="gnucap-dev"
MCHS_PKG_GROUPS="science"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build () {
	cp -r $MCHS_PKG_SRCDIR/* .
	./configure
	(cd lib && make)
	(cd modelgen && make)
}

mchs_step_pre_configure () {
	sed -i "s%@MCHS_PKG_HOSTBUILD_DIR@%$MCHS_PKG_HOSTBUILD_DIR%g" $MCHS_PKG_SRCDIR/apps/Make1
}

mchs_step_configure () {
	$MCHS_PKG_SRCDIR/configure --prefix=$MCHS_PREFIX
}
