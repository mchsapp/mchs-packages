MCHS_PKG_HOMEPAGE=https://beyondgrep.com/
MCHS_PKG_DESCRIPTION="Tool like grep optimized for programmers"
MCHS_PKG_LICENSE="Artistic-License-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.5.0
MCHS_PKG_SRCURL=https://beyondgrep.com/ack-v${MCHS_PKG_VERSION}
MCHS_PKG_SHA256=6870d3c90691c3c4a9ec2ae69880e85c5188aa57adeeca2a794b477e034b989f
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	mchs_download \
		$MCHS_PKG_SRCURL \
		$MCHS_PREFIX/bin/ack \
		$MCHS_PKG_SHA256
	touch $MCHS_PREFIX/bin/ack
	chmod +x $MCHS_PREFIX/bin/ack
}
