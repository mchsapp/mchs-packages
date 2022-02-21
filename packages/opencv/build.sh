MCHS_PKG_HOMEPAGE=https://opencv.org/
MCHS_PKG_DESCRIPTION="Open Source Computer Vision Library"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.5.5
MCHS_PKG_SRCURL=https://github.com/opencv/opencv/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a1cfdcf6619387ca9e232687504da996aaa9f7b5689986b8331ec02cb61d28ad
MCHS_PKG_DEPENDS="libc++, libjpeg-turbo, libpng, libprotobuf, libtiff, libwebp, openjpeg, openjpeg-tools, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_MCHS=OFF
-DWITH_OPENEXR=OFF
-DBUILD_PROTOBUF=OFF
-DPROTOBUF_UPDATE_FILES=ON
"

mchs_step_pre_configure() {
	mchs_setup_protobuf

	LDFLAGS+=" -llog"

	find "$MCHS_PKG_SRCDIR" -name CMakeLists.txt -o -name '*.cmake' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_MCHS\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_MCHS/g'

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

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
	if [ $_NEED_DUMMY_LIBRT_A ]; then
		rm -f $_LIBRT_A
	fi
}
