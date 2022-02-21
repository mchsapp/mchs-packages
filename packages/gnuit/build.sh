MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gnuit/
MCHS_PKG_DESCRIPTION="gnuit - GNU Interactive Tools"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.9.5
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnuit/gnuit-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6b6e96db13bafa5ad35c735b2277699d4244088c709a3e134fb1a3e8c8a8557c
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-transition"
MCHS_PKG_DEPENDS="libandroid-support, ncurses"

mchs_step_post_massage() {
	cd $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/share/gnuit
	ln -s gnuitrc.xterm-color gnuitrc.xterm-256color
	ln -s gnuitrc.screen gnuitrc.screen-color
	ln -s gnuitrc.screen gnuitrc.screen-256color
}
