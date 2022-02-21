MCHS_PKG_HOMEPAGE=http://www.ltrace.org/
MCHS_PKG_DESCRIPTION="Tracks runtime library calls in dynamically linked programs"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:0.7.3
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/dkogan/ltrace/archive/82c66409c7a93ca6ad2e4563ef030dfb7e6df4d4.tar.gz
MCHS_PKG_SHA256=4aecf69e4a33331aed1e50ce4907e73a98cbccc4835febc3473863474304d547
MCHS_PKG_DEPENDS="libc++, libelf"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-werror
--without-libunwind
ac_cv_host=$MCHS_ARCH-generic-linux-gnu
"

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH" == "arm" ]; then
		CFLAGS+=" -DSHT_ARM_ATTRIBUTES=0x70000000+3"
	fi

	autoreconf -i ../src
}
