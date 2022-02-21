MCHS_PKG_HOMEPAGE=https://miniupnp.tuxfamily.org/
MCHS_PKG_DESCRIPTION="Small UPnP client library and tool to access Internet Gateway Devices"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2.2
MCHS_PKG_SRCURL=https://miniupnp.tuxfamily.org/files/miniupnpc-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=888fb0976ba61518276fe1eda988589c700a3f2a69d71089260d75562afd3687
MCHS_PKG_BREAKS="miniupnpc-dev"
MCHS_PKG_REPLACES="miniupnpc-dev"

mchs_step_post_make_install() {
	install -Dm700 upnpc-static "$MCHS_PREFIX/bin/upnpc"
}
