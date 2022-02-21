MCHS_PKG_HOMEPAGE=https://github.com/edghyhdz/crypto_monitor
MCHS_PKG_DESCRIPTION="Real-time crypto currency monitor"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=86fd7de705babc2cef1e920e39ec439f5aa9c336
MCHS_PKG_VERSION=2021.02.22
MCHS_PKG_SRCURL=https://github.com/edghyhdz/crypto_monitor.git
MCHS_PKG_GIT_BRANCH=main
MCHS_PKG_DEPENDS="libc++, libcurl, ncurses-ui-libs, openssl"
MCHS_PKG_BUILD_DEPENDS="boost"
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

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin executable/crypto_monitor
}
