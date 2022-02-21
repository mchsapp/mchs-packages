MCHS_PKG_HOMEPAGE=https://github.com/noncombatant/robotfindskitten
MCHS_PKG_DESCRIPTION="A very fun adventure game for robots and humans"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=42a5cb783a59bf34dc0d1e925fd615f022674721
MCHS_PKG_VERSION=2021.08.18
MCHS_PKG_SRCURL=https://github.com/noncombatant/robotfindskitten.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="-e"
MCHS_PKG_GROUPS="games"

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$MCHS_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$MCHS_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

mchs_step_pre_configure() {
	LDFLAGS+=" -lncursesw"
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin robotfindskitten
}
