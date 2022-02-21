MCHS_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3highlight.html
MCHS_PKG_DESCRIPTION="A library for syntax highlighting different types of text files"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.0
MCHS_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3highlight-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=8216190785e52a116f9f78ec6513815745904c2aaf70d0a0a09438e08640dfbb
MCHS_PKG_DEPENDS="libt3config, pcre2"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"

mchs_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
}

mchs_step_pre_configure() {
	local libtooldir=$MCHS_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$MCHS_SCRIPTDIR/scripts/config.sub" ./
	cp "$MCHS_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$MCHS_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool
}
