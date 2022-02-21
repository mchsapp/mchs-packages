MCHS_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3widget.html
MCHS_PKG_DESCRIPTION="A library of widgets and dialogs to facilitate construction of easy-to-use terminal-based programs"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.2
MCHS_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3widget-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=9eb7e1d0ccdfc917f18ba1785a2edb4faa6b0af8b460653d962abf91136ddf1c
MCHS_PKG_DEPENDS="libc++, libt3key, libt3window, libtranscript, libunistring, pcre2"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--without-gettext
--without-x11
--without-gpm
"

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
		AC_PROG_CXX
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$MCHS_SCRIPTDIR/scripts/config.sub" ./
	cp "$MCHS_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$MCHS_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool

	CXXFLAGS+=" $CPPFLAGS"
}
