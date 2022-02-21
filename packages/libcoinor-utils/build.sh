MCHS_PKG_HOMEPAGE=https://github.com/coin-or/CoinUtils
MCHS_PKG_DESCRIPTION="An open-source collection of classes and helper functions for COIN-OR projects"
MCHS_PKG_LICENSE="EPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=9035d7a1b5b6daed9b067f16f440420e4477abac
MCHS_PKG_VERSION=2022.01.03
MCHS_PKG_SRCURL=https://github.com/coin-or/CoinUtils.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libc++"

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
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
