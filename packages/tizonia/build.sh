MCHS_PKG_HOMEPAGE=https://github.com/tizonia/
MCHS_PKG_DESCRIPTION="A command-line streaming music client/server for Linux"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.22.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/tizonia/tizonia-openmax-il/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0750cae23ed600fb4b4699a392f43a5e03dcd0870383d64da4b8c28ea94a82f8
MCHS_PKG_DEPENDS="boost, dbus, libandroid-wordexp, libcurl, libflac, liblog4c, libmad, libmediainfo, libmp3lame, liboggz, libopus, libsndfile, libsqlite, libuuid, libvpx, mpg123, opusfile, pulseaudio, python, taglib"
MCHS_PKG_BUILD_DEPENDS="libev"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	_PREFIX_FOR_BUILD=$MCHS_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD
	local srcdir="$MCHS_PKG_SRCDIR"/3rdparty/dbus-cplusplus
	autoreconf -fi "$srcdir"
	"$srcdir"/configure --prefix=$_PREFIX_FOR_BUILD
	make -j $MCHS_MAKE_PROCESSES
	make install
}

mchs_step_pre_configure() {
	install -Dm700 $MCHS_PKG_BUILDER_DIR/exe_wrapper $_PREFIX_FOR_BUILD/bin/
	PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	export BOOST_ROOT=$MCHS_PREFIX
	LDFLAGS+=" -landroid-wordexp"

	_NEED_DUMMY_LIBPTHREAD_A=
	_LIBPTHREAD_A=$MCHS_PREFIX/lib/libpthread.a
	if [ ! -e $_LIBPTHREAD_A ]; then
		_NEED_DUMMY_LIBPTHREAD_A=true
		echo '!<arch>' > $_LIBPTHREAD_A
	fi
	_NEED_DUMMY_LIBRT_A=
	_LIBRT_A=$MCHS_PREFIX/lib/librt.a
	if [ ! -e $_LIBRT_A ]; then
		_NEED_DUMMY_LIBRT_A=true
		echo '!<arch>' > $_LIBRT_A
	fi
}

mchs_step_configure_meson() {
	mchs_setup_meson
	sed -i 's/^\(\[binaries\]\)$/\1\nexe_wrapper = '\'exe_wrapper\''/g' \
		$MCHS_MESON_CROSSFILE
	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $MCHS_MESON \
		$MCHS_PKG_SRCDIR \
		$MCHS_PKG_BUILDDIR \
		--cross-file $MCHS_MESON_CROSSFILE \
		--prefix $MCHS_PREFIX \
		--libdir lib \
		--buildtype minsize \
		--strip \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
	if [ $_NEED_DUMMY_LIBRT_A ]; then
		rm -f $_LIBRT_A
	fi
}
