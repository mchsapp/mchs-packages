MCHS_PKG_HOMEPAGE=https://invisible-island.net/dialog/
MCHS_PKG_DESCRIPTION="Application used in shell scripts which displays text user interface widgets"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_DEPENDS="libandroid-support, ncurses"
MCHS_PKG_VERSION="1.3-20211214"
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/dialog-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=cc2965e05c6a8c37070b36b56414eaa560df8d87f2cea21759e28950e9b27a4b
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-ncursesw --enable-widec --with-pkg-config"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# Put a temporary link for libtinfo.so
	ln -s -f $MCHS_PREFIX/lib/libncursesw.so $MCHS_PREFIX/lib/libtinfo.so
}

mchs_step_post_make_install() {
	rm $MCHS_PREFIX/lib/libtinfo.so
}
