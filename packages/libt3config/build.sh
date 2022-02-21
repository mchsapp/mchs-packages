MCHS_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3config.html
MCHS_PKG_DESCRIPTION="A library for reading and writing configuration files"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.0
MCHS_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3config-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=1aba7262ed79b11b30f93d02183aafde49c9d6655f08ac438b26af3151908c01
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
