MCHS_PKG_HOMEPAGE=http://lynx.browser.org/
MCHS_PKG_DESCRIPTION="The text web browser"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.8.9rel.1
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=http://invisible-mirror.net/archives/lynx/tarballs/lynx${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=387f193d7792f9cfada14c60b0e5c0bff18f227d9257a39483e14fa1aaf79595
MCHS_PKG_DEPENDS="libiconv, ncurses, openssl, libbz2, libidn, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-screen=ncursesw --enable-widec --enable-scrollbar --enable-nested-tables --enable-htmlized-cfg --with-ssl --with-zlib --with-bzlib --enable-cjk --enable-japanese-utf8 --enable-progressbar --enable-prettysrc --enable-forms-options --enable-8bit-toupper --enable-ascii-ctypes --disable-font-switch --with-mime-libdir=$MCHS_PREFIX/etc"

## set default paths for tools that may be used in runtime by 'lynx' binary
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_BZIP2=${MCHS_PREFIX}/bin/bzip2"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_COMPRESS=${MCHS_PREFIX}/bin/compress"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_GZIP=${MCHS_PREFIX}/bin/gzip"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_INSTALL=${MCHS_PREFIX}/bin/install"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MSGINIT=${MCHS_PREFIX}/bin/msginit"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MV=${MCHS_PREFIX}/bin/mv"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_RM=${MCHS_PREFIX}/bin/rm"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TAR=${MCHS_PREFIX}/bin/tar"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TELNET=${MCHS_PREFIX}/bin/telnet"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNCOMPRESS=${MCHS_PREFIX}/bin/uncompress"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNZIP=${MCHS_PREFIX}/bin/unzip"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UUDECODE=${MCHS_PREFIX}/bin/uudecode"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZCAT=${MCHS_PREFIX}/bin/zcat"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZIP=${MCHS_PREFIX}/bin/zip"

mchs_step_pre_configure() {
	CC+=" $LDFLAGS"
	unset LDFLAGS
}

mchs_step_make_install() {
	make uninstall
	make install
}
