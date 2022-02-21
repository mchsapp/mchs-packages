MCHS_PKG_HOMEPAGE=https://speex.org/
MCHS_PKG_DESCRIPTION="Speex audio processing library"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/xiph/speexdsp/archive/SpeexDSP-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d7032f607e8913c019b190c2bccc36ea73fc36718ee38b5cdfc4e4c0a04ce9a4
MCHS_PKG_BREAKS="speexdsp-dev"
MCHS_PKG_REPLACES="speexdsp-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-neon"
MCHS_PKG_RM_AFTER_INSTALL="share/doc/speexdsp/manual.pdf"

mchs_step_pre_configure() {
	./autogen.sh
}
