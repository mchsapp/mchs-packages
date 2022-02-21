MCHS_PKG_HOMEPAGE=https://fusesource.github.io/jansi/
MCHS_PKG_DESCRIPTION="A small java library that allows you to use ANSI escape codes to format your console output"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4.0
MCHS_PKG_SRCURL=https://github.com/fusesource/jansi.git
MCHS_PKG_GIT_BRANCH=jansi-${MCHS_PKG_VERSION}
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="-C src/main/native PREFIX=$MCHS_PREFIX"

mchs_step_pre_configure() {
	cp $MCHS_PKG_BUILDER_DIR/Makefile $MCHS_PKG_SRCDIR/src/main/native/

	CFLAGS+=" -fPIC"
}
