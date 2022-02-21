MCHS_PKG_HOMEPAGE=http://www.fftw.org/
MCHS_PKG_DESCRIPTION="Library for computing the Discrete Fourier Transform (DFT) in one or more dimensions"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.3.10
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=http://www.fftw.org/fftw-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
MCHS_PKG_BREAKS="fftw-dev"
MCHS_PKG_REPLACES="fftw-dev"
# ac_cv_func_clock_gettime=no avoids having clock_gettime(CLOCK_SGI_CYCLE, &t)
# being used. It's not supported on Android but fails at runtime and, fftw
# does not check the return value so gets bogus values.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-threads ac_cv_func_clock_gettime=no"
MCHS_PKG_RM_AFTER_INSTALL="include/fftw*.f*"

mchs_step_post_make_install() {
	local COMMON_ARGS="$MCHS_PKG_EXTRA_CONFIGURE_ARGS"
	local feature
	for feature in float long-double; do
		make clean
		MCHS_PKG_EXTRA_CONFIGURE_ARGS="$COMMON_ARGS --enable-$feature"
		rm -Rf $MCHS_PKG_TMPDIR/config-scripts
		mchs_step_configure
		make -j $MCHS_MAKE_PROCESSES install
	done
}
