MCHS_PKG_HOMEPAGE=https://github.com/hyperrealm/libconfig
MCHS_PKG_DESCRIPTION="C/C++ Configuration File Library"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/hyperrealm/libconfig/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=68757e37c567fd026330c8a8449aa5f9cac08a642f213f2687186b903bd7e94e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BREAKS="libconfig-dev"
MCHS_PKG_REPLACES="libconfig-dev"

mchs_step_pre_configure() {
	autoreconf -fi
}
