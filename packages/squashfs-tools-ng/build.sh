MCHS_PKG_HOMEPAGE=https://github.com/AgentD/squashfs-tools-ng
MCHS_PKG_DESCRIPTION="New set of tools for working with SquashFS images"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@wmcbtech30"
MCHS_PKG_VERSION="1.1.3"
MCHS_PKG_SRCURL="https://github.com/AgentD/squashfs-tools-ng/archive/v${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256="4214083eb921b89d194e41697c31dc086c059518e51fe0ee4eee88318c19ad0d"
MCHS_PKG_DEPENDS="zlib, liblz4, liblzo, zstd"

mchs_step_pre_configure(){
	autoreconf -fi
}
