MCHS_PKG_HOMEPAGE=https://www.si6networks.com/research/tools/ipv6toolkit/
MCHS_PKG_DESCRIPTION="SI6 Networks IPv6 Toolkit"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=babee5e172f680ff18354d9d9918c3f7356d48d3
MCHS_PKG_VERSION=2021.03.30
MCHS_PKG_SRCURL=https://github.com/fgont/ipv6toolkit.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libpcap"
MCHS_PKG_RECOMMENDS="curl, perl"
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

mchs_step_pre_configure() {
	rm -f Makefile
}
