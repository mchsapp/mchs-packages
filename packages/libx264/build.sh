MCHS_PKG_HOMEPAGE=https://www.videolan.org/developers/x264.html
MCHS_PKG_DESCRIPTION="Library for encoding video streams into the H.264/MPEG-4 AVC format"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:0.161.3049 # X264_BUILD from x264.h; commit count
_COMMIT=55d517bc4569272a2c9a367a4106c234aba2ffbc
MCHS_PKG_SRCURL=https://code.videolan.org/videolan/x264/-/archive/$_COMMIT/x264-$_COMMIT.tar.bz2
MCHS_PKG_SHA256=f4b781e1e33f77e7bf283648537f38a3dd107589de7a87973df6d26480faf5d2
MCHS_PKG_BREAKS="libx264-dev"
MCHS_PKG_REPLACES="libx264-dev"
# Avoid linking against ffmpeg libraries to avoid circular dependency:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-swscale
--disable-lavf"

mchs_step_pre_configure() {
	#if [ $MCHS_ARCH = "i686" -o $MCHS_ARCH = "x86_64" ]; then
	if [ $MCHS_ARCH = "i686" ]; then
		# Avoid text relocations on i686, see:
		# https://mailman.videolan.org/pipermail/x264-devel/2016-March/011589.html
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
		# Avoid errors such as "relocation R_386_GOTOFF against preemptible symbol
		# x264_significant_coeff_flag_offset cannot be used when making a shared object":
		LDFLAGS+=" -fuse-ld=bfd"
	elif [ $MCHS_ARCH = "x86_64" ]; then
		# Avoid requiring nasm for now:
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}
