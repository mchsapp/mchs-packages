MCHS_PKG_HOMEPAGE=https://gitlab.com/berdyansk/astra-sm
MCHS_PKG_DESCRIPTION="Software for digital TV broadcasting"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=44bcd2852b7f315233267f639730e0e21b9b6c22
MCHS_PKG_VERSION=2019.06.19
MCHS_PKG_SRCURL=https://github.com/OpenVisionE2/astra-sm.git
MCHS_PKG_GIT_BRANCH=staging
MCHS_PKG_DEPENDS="libdvbcsa, liblua53"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-lua-includes=$MCHS_PREFIX/include/lua5.3
--with-lua-libs=$MCHS_PREFIX/lib/liblua5.3.so
--with-lua-compiler=no
--with-ffmpeg=no
--with-libcrypto=no
"

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
}
