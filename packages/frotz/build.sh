MCHS_PKG_HOMEPAGE=https://gitlab.com/DavidGriffith/frotz
MCHS_PKG_DESCRIPTION="Interpreter for Infocom and other Z-machine interactive fiction (IF) games"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
# frotz does not depend on dialog or curl, but the zgames script we bundle below in mchs_step_make_install() do.
MCHS_PKG_VERSION=2.53
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://gitlab.com/DavidGriffith/frotz/-/archive/${MCHS_PKG_VERSION}/frotz-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ed288b2ddad6c100f7ad7cb6ee8c867053d75144e96160b5ba00abb8969cdf30
MCHS_PKG_DEPENDS="ncurses, dialog, curl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

mchs_step_pre_configure () {
	export CURSES_CFLAGS="-I$MCHS_PREFIX/include"
	export SYSCONFDIR="$MCHS_PREFIX/include"
	export SOUND_TYPE="none"
}

mchs_step_post_make_install () {
	install -m755 $MCHS_PKG_BUILDER_DIR/zgames $MCHS_PREFIX/bin/zgames
}
