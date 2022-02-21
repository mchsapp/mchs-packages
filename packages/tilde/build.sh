MCHS_PKG_HOMEPAGE=https://os.ghalkes.nl/tilde/
MCHS_PKG_DESCRIPTION="A text editor for the console/terminal"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.3
MCHS_PKG_SRCURL=https://os.ghalkes.nl/dist/tilde-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=6b86ffaa5c632c9055f74fca713c5bf8420ee60718850dc16a95abe49fa2641a
MCHS_PKG_DEPENDS="libc++, libt3config, libt3highlight, libt3widget, libtranscript, libunistring"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"

mchs_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
	rm -f src/tilde
	find src -type f | xargs -n 1 sed -i 's:tilde/::g'
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
