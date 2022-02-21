MCHS_PKG_HOMEPAGE=https://uftrace.github.io/slide
MCHS_PKG_DESCRIPTION="Function (graph) tracer for user-space"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.4
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/namhyung/uftrace/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=418d30c959d3b6d0dcafd55e588a5d414a9984b30f2522a5af004a268824a5a2
MCHS_PKG_DEPENDS="capstone, libandroid-glob, libandroid-spawn, libelf, libdw, ncurses, python"
MCHS_PKG_BUILD_DEPENDS="argp"

mchs_step_pre_configure() {
	# uftrace uses custom configure script implementation, so we need to provide some flags
	export CFLAGS="${CFLAGS} -I${MCHS_PREFIX}/include -I${MCHS_PREFIX}/include/python3.10 -DEFD_SEMAPHORE=1 -DEF_ARM_ABI_FLOAT_HARD=0x400 -w"
	export LDFLAGS="${LDFLAGS} -Wl,--wrap=_Unwind_Resume -landroid-glob -largp -lpython3.10"

	if [ "$MCHS_ARCH" = "i686" ]; then
		export ARCH="i386"
	else
		export ARCH="$MCHS_ARCH"
	fi
}
