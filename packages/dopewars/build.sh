MCHS_PKG_HOMEPAGE=https://dopewars.sourceforge.io
MCHS_PKG_DESCRIPTION="Drug-dealing game set in streets of New York City"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.1
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://prdownloads.sourceforge.net/dopewars/dopewars-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=83127903a61d81cda251a022f9df150d11e27bdd040e858c09c57927cc0edea6
MCHS_PKG_DEPENDS="ncurses, glib, pcre, curl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--without-sdl
"
MCHS_PKG_RM_AFTER_INSTALL="share/gnome"
MCHS_PKG_GROUPS="games"

mchs_step_pre_configure() {
	autoreconf -vfi
}
