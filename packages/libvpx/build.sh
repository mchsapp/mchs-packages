MCHS_PKG_HOMEPAGE=https://www.webmproject.org
MCHS_PKG_DESCRIPTION="VP8 & VP9 Codec SDK"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/webmproject/libvpx/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=85803ccbdbdd7a3b03d930187cb055f1353596969c1f92ebec2db839fa4f834a
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BREAKS="libvpx-dev"
MCHS_PKG_REPLACES="libvpx-dev"

mchs_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# Force fresh install of header files:
	rm -Rf $MCHS_PREFIX/include/vpx

	export LD=$CC

	if [ $MCHS_ARCH = "arm" ]; then
		export AS=$MCHS_HOST_PLATFORM-as
		_CONFIGURE_TARGET="--target=armv7-android-gcc"
	elif [ $MCHS_ARCH = "i686" ]; then
		export AS=yasm
		_CONFIGURE_TARGET="--target=x86-android-gcc"
	elif [ $MCHS_ARCH = "aarch64" ]; then
		_CONFIGURE_TARGET="--force-target=arm64-v8a-android-gcc"
	elif [ $MCHS_ARCH = "x86_64" ]; then
		export AS=yasm
		_CONFIGURE_TARGET="--target=x86_64-android-gcc"
	else
		mchs_error_exit "Unsupported arch: $MCHS_ARCH"
	fi

	# For --disable-realtime-only, see
	# https://bugs.chromium.org/p/webm/issues/detail?id=800
	# "The issue is that on android we soft enable realtime only.
	#  [..] You can enable non-realtime by setting --disable-realtime-only"
	# Discovered in https://github.com/mchs/mchs-packages/issues/554
	#CROSS=${MCHS_HOST_PLATFORM}- CC=clang CXX=clang++ $MCHS_PKG_SRCDIR/configure \
	$MCHS_PKG_SRCDIR/configure \
		$_CONFIGURE_TARGET \
		--prefix=$MCHS_PREFIX \
		--disable-examples \
		--disable-realtime-only \
		--disable-unit-tests \
		--enable-pic \
		--enable-vp8 \
		--enable-shared \
		--enable-small \
		--extra-cflags="-fPIC"
}
