MCHS_PKG_HOMEPAGE=http://wiz-lang.org/
MCHS_PKG_DESCRIPTION="A high-level assembly language for writing homebrew software for retro console platforms"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=b25ba2d90288fc8a380d99b3ad08a5b48caaa484
MCHS_PKG_VERSION=2021.06.02
MCHS_PKG_SRCURL=https://github.com/wiz-lang/wiz.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="PREFIX=$MCHS_PREFIX"

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
