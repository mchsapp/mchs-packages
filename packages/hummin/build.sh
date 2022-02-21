MCHS_PKG_HOMEPAGE=https://trantor.is/
MCHS_PKG_DESCRIPTION="Command line client for the imperial library of trantor"
MCHS_PKG_LICENSE="WTFPL"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=b117aef9c64348b1ef262a99316f1e51328efe18
MCHS_PKG_VERSION=2021.05.18
MCHS_PKG_SRCURL=https://gitlab.com/trantor/hummin.git
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

	go mod init || :
	go mod tidy
	go build
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin hummin
}
