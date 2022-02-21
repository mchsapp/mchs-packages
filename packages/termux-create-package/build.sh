MCHS_PKG_HOMEPAGE=https://github.com/mchs/mchs-create-package
MCHS_PKG_DESCRIPTION="Utility to create McHs packages"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.12.0
MCHS_PKG_SRCURL=https://github.com/mchs/mchs-create-package/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=13bcc1264844e9865eeab19805f24ff28bbfac8d39c11bca66f4357fa70e6ace
MCHS_PKG_DEPENDS="binutils, python"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin src/mchs-create-package
}
