MCHS_PKG_HOMEPAGE=https://github.com/direnv/direnv
MCHS_PKG_DESCRIPTION="Environment switcher for shell"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.30.3
MCHS_PKG_SRCURL=https://github.com/direnv/direnv/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=7fb5431b98d57fb8c70218b4a0fab4b08f102790e7a92486f588bf3d5751ac3b
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
 	mchs_setup_golang
}
