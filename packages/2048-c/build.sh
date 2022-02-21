MCHS_PKG_HOMEPAGE=https://github.com/mevdschee/2048.c
MCHS_PKG_DESCRIPTION="Console version of the game '2048' for GNU/Linux"
MCHS_PKG_LICENSE="MIT"
_COMMIT=bdb7527db2c4b5ce5eb8b8067ed9c0330ead77ea
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2021.04.22
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/mevdschee/2048.c.git
MCHS_PKG_GIT_BRANCH=main
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
