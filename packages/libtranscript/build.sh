MCHS_PKG_HOMEPAGE=https://os.ghalkes.nl/libtranscript.html
MCHS_PKG_DESCRIPTION="A character-set conversion library"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.3.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://os.ghalkes.nl/dist/libtranscript-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=1f8c19f257da5d6fad0ed9a7e5bd2442819e910a19907c38e115116a3955f5fa
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
