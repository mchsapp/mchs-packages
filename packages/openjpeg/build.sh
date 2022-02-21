MCHS_PKG_HOMEPAGE=http://www.openjpeg.org/
MCHS_PKG_DESCRIPTION="JPEG 2000 image compression library"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4.0
MCHS_PKG_SRCURL=https://github.com/uclouvain/openjpeg/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8702ba68b442657f11aaeb2b338443ca8d5fb95b0d845757968a7be31ef7f16d
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="openjpeg-dev"
MCHS_PKG_REPLACES="openjpeg-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_STATIC_LIBS=OFF"
# for fast building packages that depend on openjpeg with cmake

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# Force symlinks to be overwritten:
	rm -Rf $MCHS_PREFIX/lib/libopenjp2.so*
}
