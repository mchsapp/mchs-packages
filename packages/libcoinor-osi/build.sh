MCHS_PKG_HOMEPAGE=https://github.com/coin-or/Osi
MCHS_PKG_DESCRIPTION="An abstract base class to a generic linear programming (LP) solver"
MCHS_PKG_LICENSE="EPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=01ada0ee8d423b4401ac04418c8300a04dd2beaf
MCHS_PKG_VERSION=2022.01.01
MCHS_PKG_SRCURL=https://github.com/coin-or/Osi.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libc++, libcoinor-utils"

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
