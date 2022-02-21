MCHS_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/pkg-config/
MCHS_PKG_DESCRIPTION="Helper tool used when compiling applications and libraries"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.29.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://pkgconfig.freedesktop.org/releases/pkg-config-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591
MCHS_PKG_DEPENDS="glib"
MCHS_PKG_RM_AFTER_INSTALL="bin/*-pkg-config"
MCHS_PKG_GROUPS="base-devel"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	rm -Rf $MCHS_PREFIX/bin/*pkg-config
}
