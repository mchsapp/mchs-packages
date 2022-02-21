MCHS_PKG_HOMEPAGE=https://github.com/seenaburns/stag
MCHS_PKG_DESCRIPTION="Streaming bar graphs. For stats and stuff."
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.0
MCHS_PKG_SRCURL=https://github.com/seenaburns/stag/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=391574e6aa12856d5a598a374e3a40a38cbab6ef9d769c0d59af8411b4fbecb6
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CFLAGS+=" $LDFLAGS"
}
