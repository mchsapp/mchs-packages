MCHS_PKG_HOMEPAGE=https://github.com/mchs/mchs-auth
MCHS_PKG_DESCRIPTION="Password authentication library and utility for McHs"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4
MCHS_PKG_SRCURL=https://github.com/mchs/mchs-auth/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=539bc4f8271878d3402e8f54030441e345cfb8d0d635fa59c541f51d21e939d0
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BREAKS="mchs-auth-dev"
MCHS_PKG_REPLACES="mchs-auth-dev"

mchs_step_pre_configure() {
	CPPFLAGS+=" -DMCHS_HOME=\\\"${MCHS_ANDROID_HOME}\\\" -DMCHS_PREFIX=\\\"${MCHS_PREFIX}\\\""
}
