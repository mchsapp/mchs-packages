MCHS_PKG_HOMEPAGE=https://liquidsdr.org/
MCHS_PKG_DESCRIPTION="Software-defined radio digital signal processing library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.2
MCHS_PKG_SRCURL=https://github.com/jgaeddert/liquid-dsp/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=85093624ef9cb90ead64c836d2f42690197edace1a86257d6524c4e4dc870483
MCHS_PKG_DEPENDS="fftw"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	autoreconf -fi
}
