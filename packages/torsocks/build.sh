MCHS_PKG_HOMEPAGE=https://github.com/dgoulet/torsocks
MCHS_PKG_DESCRIPTION="Wrapper to safely torify applications"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/dgoulet/torsocks/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=817c143e8a9d217f41a223a85139c6ca28e1b99556c547fcdb4c72dbc170b6c9
MCHS_PKG_DEPENDS="tor"

mchs_step_pre_configure() {
	./autogen.sh
}

