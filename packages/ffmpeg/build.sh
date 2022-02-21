MCHS_PKG_HOMEPAGE=https://ffmpeg.org
MCHS_PKG_DESCRIPTION="Tools and libraries to manipulate a wide range of multimedia formats and protocols"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
# NOTE: mpv has to be rebuilt and version bumped after updating ffmpeg.
MCHS_PKG_VERSION=5.0
MCHS_PKG_SRCURL=https://www.ffmpeg.org/releases/ffmpeg-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=51e919f7d205062c0fd4fae6243a84850391115104ccf1efc451733bc0ac7298
MCHS_PKG_DEPENDS="libaom, libass, libbz2, libdav1d, libiconv, librav1e, libsoxr, libx264, libx265, xvidcore, libvorbis, libmp3lame, libopus, libvpx, libgnutls, libandroid-glob, freetype, zlib, liblzma, libvidstab, libwebp, libxml2"
MCHS_PKG_CONFLICTS="libav"
MCHS_PKG_BREAKS="ffmpeg-dev"
MCHS_PKG_REPLACES="ffmpeg-dev"


mchs_step_configure() {
	cd $MCHS_PKG_BUILDDIR

	export ASFLAGS="-no-integrated-as"

	local _EXTRA_CONFIGURE_FLAGS=""
	if [ $MCHS_ARCH = "arm" ]; then
		_ARCH="armeabi-v7a"
		_EXTRA_CONFIGURE_FLAGS="--enable-neon"
	elif [ $MCHS_ARCH = "i686" ]; then
		_ARCH="x86"
		# Specify --disable-asm to prevent text relocations on i686,
		# see https://trac.ffmpeg.org/ticket/4928
		_EXTRA_CONFIGURE_FLAGS="--disable-asm"
	elif [ $MCHS_ARCH = "x86_64" ]; then
		_ARCH="x86_64"
	elif [ $MCHS_ARCH = "aarch64" ]; then
		_ARCH=$MCHS_ARCH
		_EXTRA_CONFIGURE_FLAGS="--enable-neon"
	else
		mchs_error_exit "Unsupported arch: $MCHS_ARCH"
	fi

	$MCHS_PKG_SRCDIR/configure \
		--arch="${_ARCH}" \
		--as="$AS" \
		--cc="$CC" \
		--cxx="$CXX" \
		--nm="$NM" \
		--pkg-config="$PKG_CONFIG" \
		--strip="$STRIP" \
		--cross-prefix="${MCHS_HOST_PLATFORM}-" \
		--disable-indevs \
		--disable-outdevs \
		--enable-indev=lavfi \
		--disable-static \
		--disable-symver \
		--enable-cross-compile \
		--enable-gnutls \
		--enable-gpl \
		--enable-libaom \
		--enable-libass \
		--enable-libdav1d \
		--enable-libmp3lame \
		--enable-libfreetype \
		--enable-libvorbis \
		--enable-libopus \
		--enable-librav1e \
		--enable-libsoxr \
		--enable-libx264 \
		--enable-libx265 \
		--enable-libxvid \
		--enable-libvidstab \
		--enable-libvpx \
		--enable-libwebp \
		--enable-libxml2 \
		--enable-shared \
		--prefix="$MCHS_PREFIX" \
		--target-os=android \
		--extra-libs="-landroid-glob" \
		$_EXTRA_CONFIGURE_FLAGS
}
