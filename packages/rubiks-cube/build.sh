MCHS_PKG_HOMEPAGE=https://github.com/been-jamming/rubiks_cube
MCHS_PKG_DESCRIPTION="A rubik's cube that runs in your terminal"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2
MCHS_PKG_SRCURL=https://github.com/been-jamming/rubiks_cube.git
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin rubiks_cube
}
