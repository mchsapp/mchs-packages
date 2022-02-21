MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gcal/
MCHS_PKG_DESCRIPTION="Program for calculating and printing calendars"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.1
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gcal/gcal-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=91b56c40b93eee9bda27ec63e95a6316d848e3ee047b5880ed71e5e8e60f61ab
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

mchs_step_post_make_install() {
	# XXX: share/info/dir is currently included in emacs.
	# We should probably make texinfo regenerate that file
	# just as the man package does with the man database.
	rm -f $MCHS_PREFIX/share/info/dir
}
