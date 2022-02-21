MCHS_PKG_HOMEPAGE=http://zssh.sourceforge.net/
MCHS_PKG_DESCRIPTION="A program for interactively transferring files to a remote machine while using the secure shell (ssh)"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5c
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/zssh/zssh-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=a2e840f82590690d27ea1ea1141af509ee34681fede897e58ae8d354701ce71b
MCHS_PKG_DEPENDS="libandroid-glob, lrzsz, openssh, readline"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	echo "ac_cv_func_getpgrp_void=yes" >> config.cache
	LDFLAGS+=" -landroid-glob"
}
