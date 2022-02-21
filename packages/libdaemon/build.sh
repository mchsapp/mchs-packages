MCHS_PKG_HOMEPAGE=https://0pointer.de/lennart/projects/libdaemon/
MCHS_PKG_DESCRIPTION="A lightweight C library that eases the writing of UNIX daemons"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.14
MCHS_PKG_SRCURL=https://0pointer.de/lennart/projects/libdaemon/libdaemon-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes"

mchs_step_pre_configure() {
	autoreconf -fi
}
