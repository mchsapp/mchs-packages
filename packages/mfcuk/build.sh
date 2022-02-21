MCHS_PKG_HOMEPAGE=https://github.com/nfc-tools/mfcuk
MCHS_PKG_DESCRIPTION="MiFare Classic Universal toolKit (MFCUK)"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=b333a7925a3be80d9496c88c9fef816777827a83
MCHS_PKG_VERSION=2018.07.14
MCHS_PKG_SRCURL=https://github.com/nfc-tools/mfcuk.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libnfc"

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
