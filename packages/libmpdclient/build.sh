MCHS_PKG_HOMEPAGE=https://www.musicpd.org/libs/libmpdclient/
MCHS_PKG_DESCRIPTION="Asynchronous API library for interfacing MPD in the C, C++ & Objective C languages"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.20
MCHS_PKG_SRCURL=https://github.com/MusicPlayerDaemon/libmpdclient/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3c5a671e7bc5736c677ef75017eaf008e8838ac03605953410e8d4de6b363b73
MCHS_PKG_BREAKS="libmpdclient-dev"
MCHS_PKG_REPLACES="libmpdclient-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS=" -D default_socket==${MCHS_PREFIX}/var/run/mpd/socket"
