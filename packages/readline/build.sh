MCHS_PKG_HOMEPAGE="https://tiswww.case.edu/php/chet/readline/rltop.html"
MCHS_PKG_DESCRIPTION="Library that allow users to edit command lines as they are typed in"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_DEPENDS="libandroid-support, ncurses"
MCHS_PKG_BREAKS="bash (<< 5.0), readline-dev"
MCHS_PKG_REPLACES="readline-dev"
_MAIN_VERSION=8.1
_PATCH_VERSION=1
MCHS_PKG_VERSION=$_MAIN_VERSION.$_PATCH_VERSION
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/readline/readline-${_MAIN_VERSION}.tar.gz
MCHS_PKG_SHA256=f8ceb4ee131e3232226a17f51b164afc46cd0b9e6cef344be87c65962cb82b02
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-curses --enable-multibyte bash_cv_wcwidth_broken=no"
MCHS_PKG_EXTRA_MAKE_ARGS="SHLIB_LIBS=-lncursesw"
MCHS_PKG_CONFFILES="etc/inputrc"

mchs_step_pre_configure() {
	declare -A PATCH_CHECKSUMS

	PATCH_CHECKSUMS[001]=682a465a68633650565c43d59f0b8cdf149c13a874682d3c20cb4af6709b9144

	for PATCH_NUM in $(seq -f '%03g' ${_PATCH_VERSION}); do
		PATCHFILE=$MCHS_PKG_CACHEDIR/readline_patch_${PATCH_NUM}.patch
		mchs_download \
			"http://mirrors.kernel.org/gnu/readline/readline-$_MAIN_VERSION-patches/readline${_MAIN_VERSION/./}-$PATCH_NUM" \
			$PATCHFILE \
			${PATCH_CHECKSUMS[$PATCH_NUM]}
		patch -p0 -i $PATCHFILE
	done

	CFLAGS+=" -fexceptions"
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/lib/pkgconfig
	cp readline.pc $MCHS_PREFIX/lib/pkgconfig/

	mkdir -p $MCHS_PREFIX/etc
	cp $MCHS_PKG_BUILDER_DIR/inputrc $MCHS_PREFIX/etc/
}
