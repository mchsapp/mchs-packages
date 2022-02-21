MCHS_PKG_HOMEPAGE=http://caca.zoy.org/wiki/zzuf
MCHS_PKG_DESCRIPTION="A transparent application input fuzzer"
MCHS_PKG_LICENSE="WTFPL"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=e598eef77a98d77dc6aec6fd2c845e3cd07dc4fd
MCHS_PKG_VERSION=2019.02.08
MCHS_PKG_SRCURL=https://github.com/samhocevar/zzuf.git
MCHS_PKG_GIT_BRANCH=master

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
	autoreconf -fi

	CPPFLAGS+=" -D__USE_GNU"
}
