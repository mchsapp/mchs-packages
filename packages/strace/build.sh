MCHS_PKG_HOMEPAGE=https://strace.io/
MCHS_PKG_DESCRIPTION="Debugging utility to monitor system calls and signals received"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.16
MCHS_PKG_SRCURL=https://github.com/strace/strace/releases/download/v$MCHS_PKG_VERSION/strace-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=dc7db230ff3e57c249830ba94acab2b862da1fcaac55417e9b85041a833ca285
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libdw"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-libdw
"

# This is a perl script.
MCHS_PKG_RM_AFTER_INSTALL="bin/strace-graph"

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH" = "arm" ] || [ "$MCHS_ARCH" = "i686" ] || [ "$MCHS_ARCH" = "x86_64" ]; then
		# Without st_cv_m32_mpers=no the build fails if gawk is installed.
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" st_cv_m32_mpers=no"
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mpers=no"
	fi
	autoreconf # for configure.ac in configure-find-armv7-cc.patch
	CPPFLAGS+=" -Dfputs_unlocked=fputs"
}
