MCHS_PKG_HOMEPAGE=https://github.com/open-source-parsers/jsoncpp
MCHS_PKG_DESCRIPTION="C++ library for interacting with JSON"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.9.5
MCHS_PKG_SRCURL=https://github.com/open-source-parsers/jsoncpp/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f409856e5920c18d0c2fb85276e24ee607d2a09b5e7d5f0a371368903c275da2
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BREAKS="jsoncpp-dev"
MCHS_PKG_REPLACES="jsoncpp-dev"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DJSONCPP_WITH_TESTS=OFF
-DCCACHE_FOUND=OFF
"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# The installation does not overwrite symlinks such as libjsoncpp.so.1,
	# so if rebuilding these are not detected as modified. Fix that:
	rm -f $MCHS_PREFIX/lib/libjsoncpp.so*
}
