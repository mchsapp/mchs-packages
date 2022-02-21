MCHS_PKG_HOMEPAGE=http://www.gnustep.org
MCHS_PKG_DESCRIPTION="The GNUstep makefile package"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.9.0
MCHS_PKG_SRCURL=http://ftp.gnustep.org/pub/gnustep/core/gnustep-make-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a0b066c11257879c7c85311dea69c67f6dc741ef339db6514f85b64992c40d2a
MCHS_PKG_DEPENDS="libobjc2"

mchs_step_pre_configure() {
	export OBJCXX="$CXX"
}
