MCHS_PKG_HOMEPAGE=http://software.clapper.org/daemonize/
MCHS_PKG_DESCRIPTION="Run a command as a Unix daemon"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.8
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/bmc/daemonize/archive/release-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=20c4fc9925371d1ddf1b57947f8fb93e2036eb9ccc3b43a1e3678ea8471c4c60
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes"
MCHS_PKG_EXTRA_MAKE_ARGS="INSTALL_SBIN=$MCHS_PREFIX/bin"
