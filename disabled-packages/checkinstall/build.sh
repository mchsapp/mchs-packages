# NOTE: Currently segfaults when running.
MCHS_PKG_HOMEPAGE=http://checkinstall.izto.org/
MCHS_PKG_DESCRIPTION="Installation tracker creating a package from a local install"
MCHS_PKG_VERSION=1.6.2
MCHS_PKG_SRCURL=http://checkinstall.izto.org/files/source/checkinstall-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="file, make"
MCHS_PKG_RM_AFTER_INSTALL="lib/checkinstall/locale/"

mchs_step_pre_configure() {
	CFLAGS+=" -D__off64_t=off64_t"
	CFLAGS+=" -D_STAT_VER=3"
	CFLAGS+=" -D_MKNOD_VER=1"
	CFLAGS+=" -DS_IREAD=S_IRUSR"
}

mchs_step_post_make_install() {
	mv $MCHS_PREFIX/lib/checkinstall/checkinstallrc-dist \
	   $MCHS_PREFIX/lib/checkinstall/checkinstallrc
}
