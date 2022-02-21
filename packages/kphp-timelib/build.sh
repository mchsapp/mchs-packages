MCHS_PKG_HOMEPAGE=https://github.com/derickr/timelib
MCHS_PKG_DESCRIPTION="timelib 2020.02 library fork for KPHP"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="LICENSE.rst"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=59ee82faa8d9ed42b1b9b9339e0b989cc929cd4a
MCHS_PKG_VERSION=2021.03.01
MCHS_PKG_SRCURL=https://github.com/VKCOM/timelib.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_NO_STATICSPLIT=true

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
