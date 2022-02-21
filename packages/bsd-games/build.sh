MCHS_PKG_HOMEPAGE=https://www.polyomino.org.uk/computer/software/bsd-games/
MCHS_PKG_DESCRIPTION="Classic text mode games from UNIX folklore"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="LICENSE, adventure/LICENSE, atc/LICENSE, battlestar/LICENSE, caesar/LICENSE, dab/LICENSE, drop4/LICENSE, gofish/LICENSE, gomoku/LICENSE, hangman/LICENSE, robots/LICENSE, sail/LICENSE, snake/LICENSE, spirhunt/LICENSE, worm/LICENSE, wump/LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=511ca9eb1fe71d3ab1948c0e3b61336150ff389e
MCHS_PKG_VERSION=2021.11.15
MCHS_PKG_SRCURL=https://github.com/msharov/bsd-games.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
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
