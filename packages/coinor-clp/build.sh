MCHS_PKG_HOMEPAGE=https://github.com/coin-or/Clp
MCHS_PKG_DESCRIPTION="An open-source linear programming solver"
MCHS_PKG_LICENSE="EPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=899ed6d5f9de24ddb0c31761f9551c6c861dad92
MCHS_PKG_VERSION=2022.01.01
MCHS_PKG_SRCURL=https://github.com/coin-or/Clp.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libc++, libcoinor-osi, libcoinor-utils"

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
