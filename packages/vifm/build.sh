MCHS_PKG_HOMEPAGE=https://vifm.info/
MCHS_PKG_DESCRIPTION="File manager with vi like keybindings"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.12
MCHS_PKG_SRCURL=https://github.com/vifm/vifm/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f145896c1a4237d6aa160e8616f4c600f276729a17958b6a1cf5186276815395
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ncurses, file"

mchs_step_pre_configure() {
	autoreconf -if
}
