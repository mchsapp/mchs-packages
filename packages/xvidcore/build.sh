MCHS_PKG_HOMEPAGE=https://www.xvid.com/
MCHS_PKG_DESCRIPTION="High performance and high quality MPEG-4 library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.7
MCHS_PKG_SRCURL=https://downloads.xvid.com/downloads/xvidcore-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=abbdcbd39555691dd1c9b4d08f0a031376a3b211652c0d8b3b8aa9be1303ce2d
MCHS_PKG_BREAKS="xvidcore-dev"
MCHS_PKG_REPLACES="xvidcore-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	rm -f $MCHS_PREFIX/lib/libxvid*
	export MCHS_PKG_BUILDDIR=$MCHS_PKG_BUILDDIR/build/generic
	export MCHS_PKG_SRCDIR=$MCHS_PKG_BUILDDIR

	if [ $MCHS_ARCH = i686 ]; then
		# Avoid text relocations:
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-assembly"
	fi
}

