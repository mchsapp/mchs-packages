MCHS_PKG_HOMEPAGE=https://github.com/KittyKatt/screenFetch
MCHS_PKG_DESCRIPTION="Bash Screenshot Information Tool"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.9.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/KittyKatt/screenFetch/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=aa97dcd2a8576ae18de6c16c19744aae1573a3da7541af4b98a91930a30a3178
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="bash"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
    install screenfetch-dev ${MCHS_PREFIX}/bin/screenfetch
    install screenfetch.1 ${MCHS_PREFIX}/share/man/man1/
}
