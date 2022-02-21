MCHS_PKG_HOMEPAGE=https://github.com/magiblot/tvision
MCHS_PKG_DESCRIPTION="A modern port of Turbo Vision 2.0 with Unicode support"
MCHS_PKG_LICENSE="Public Domain, MIT"
MCHS_PKG_LICENSE_FILE="COPYRIGHT"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=2dc42e226abde71c19f6b19faa716064ad044ea4
MCHS_PKG_VERSION=2022.01.16
MCHS_PKG_SRCURL=https://github.com/magiblot/tvision.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libc++, ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DTV_BUILD_EXAMPLES=OFF
-DTV_BUILD_USING_GPM=OFF
-DTV_OPTIMIZE_BUILD=OFF
"

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
