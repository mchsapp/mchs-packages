MCHS_PKG_HOMEPAGE=https://github.com/ericchiang/xpup
MCHS_PKG_DESCRIPTION="pup for XML"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=3c408621ad9b5693323acd7d1b455f78444e0c5f
MCHS_PKG_VERSION=2021.12.26
MCHS_PKG_SRCURL=https://github.com/ericchiang/xpup.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_BUILD_IN_SRC=true

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

mchs_step_make() {
	mchs_setup_golang

	go mod init
	go mod tidy
	go build
}

mchs_step_make_install() {
	install -Dm700 xpup $MCHS_PREFIX/bin/
}
