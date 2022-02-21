MCHS_PKG_HOMEPAGE=http://shnutils.freeshell.org/shntool/
MCHS_PKG_DESCRIPTION="A multi-purpose WAVE data processing and reporting utility"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.0.10
MCHS_PKG_SRCURL=http://shnutils.freeshell.org/shntool/dist/src/shntool-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=74302eac477ca08fb2b42b9f154cc870593aec8beab308676e4373a5e4ca2102

mchs_step_pre_configure() {
	autoreconf -fi
}
