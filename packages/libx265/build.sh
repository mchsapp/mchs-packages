MCHS_PKG_HOMEPAGE=http://x265.org/
MCHS_PKG_DESCRIPTION="H.265/HEVC video stream encoder library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.5
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://bitbucket.org/multicoreware/x265_git/downloads/x265_$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=e70a3335cacacbba0b3a20ec6fecd6783932288ebc8163ad74bcc9606477cae8
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BREAKS="libx265-dev"
MCHS_PKG_REPLACES="libx265-dev"

mchs_step_pre_configure() {
	local ARM_ARGS

	# Not sure if this is necessary for on-device build
	ARM_ARGS="-fno-integrated-as"

	# Not sure if this is necessary for on-device build
	# Follow mchs_step_configure_cmake.sh for now
	if [ "$MCHS_ON_DEVICE_BUILD" = false ]; then
		ARM_ARGS+=" --target=${CCMCHS_HOST_PLATFORM}"
	fi

	if [ "$MCHS_ARCH" = i686 ]; then
		# Avoid text relocations.
		MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_ASSEMBLY=OFF"
	elif [ "$MCHS_ARCH" = arm ]; then
		# Follow mchs_step_setup_toolchain.sh
		ARM_ARGS+=" -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb"
		# Avoid text relocations.
		MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_ASSEMBLY=OFF"
	fi

	MCHS_PKG_SRCDIR="$MCHS_PKG_SRCDIR/source"

	sed -i "s/@ARM_ARGS@/${ARM_ARGS}/" \
		${MCHS_PKG_SRCDIR}/CMakeLists.txt
}
