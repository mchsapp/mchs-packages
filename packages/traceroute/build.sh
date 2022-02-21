MCHS_PKG_HOMEPAGE=http://traceroute.sourceforge.net/
MCHS_PKG_DESCRIPTION="A new modern implementation of traceroute(8) utility for Linux systems"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.0
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-${MCHS_PKG_VERSION}/traceroute-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3669d22a34d3f38ed50caba18cd525ba55c5c00d5465f2d20d7472e5d81603b6
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="prefix=$MCHS_PREFIX -e"

mchs_step_configure() {
	:
}
