MCHS_PKG_HOMEPAGE=https://gitlab.com/osm-c-tools/osmctools
MCHS_PKG_DESCRIPTION="Simple tools for OpenStreetMap processing"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://gitlab.com/osm-c-tools/osmctools/-/archive/${MCHS_PKG_VERSION}/osmctools-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2f5298be5b4ba840a04f360c163849b34a31386ccd287657885e21268665f413
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_GROUPS="science"

mchs_step_pre_configure () {
	autoreconf --install
}
