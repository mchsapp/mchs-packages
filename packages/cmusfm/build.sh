MCHS_PKG_HOMEPAGE=https://github.com/Arkq/cmusfm
MCHS_PKG_DESCRIPTION="Last.fm standalone scrobbler for the cmus music player"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.1
MCHS_PKG_SRCURL=https://github.com/Arkq/cmusfm/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ff5338d4b473a3e295f3ae4273fb097c0f79c42e3d803eefdf372b51dba606f2
MCHS_PKG_DEPENDS=libcurl

mchs_step_pre_configure() {
  autoreconf --install
}
