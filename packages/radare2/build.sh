MCHS_PKG_HOMEPAGE=https://rada.re
MCHS_PKG_DESCRIPTION="Advanced Hexadecimal Editor"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.6.2
MCHS_PKG_SRCURL=https://github.com/radare/radare2/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=e1aa173b29f8c494e461b7a91022be33e6de6e15bf185e055fc999500e83bbac
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libuv"
MCHS_PKG_BREAKS="radare2-dev"
MCHS_PKG_REPLACES="radare2-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-compiler=mchs-host"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# Unset CPPFLAGS to avoid -I$MCHS_PREFIX/include. This is because
	# radare2 build will put its own -I flags after ours, which causes
	# problems due to name clashes (binutils header files).
	unset CPPFLAGS

	# If this variable is not set, then build will fail on linking with 'pthread'
	export ANDROID=1

	export OBJCOPY=$MCHS_HOST_PLATFORM-objcopy

	# Remove old libs which may mess with new build:
	rm -f $MCHS_PREFIX/lib/libr_*
}
