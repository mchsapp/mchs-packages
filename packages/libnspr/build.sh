MCHS_PKG_HOMEPAGE=https://hg.mozilla.org/projects/nspr
MCHS_PKG_DESCRIPTION="Netscape Portable Runtime (NSPR)"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.33
MCHS_PKG_SRCURL=https://archive.mozilla.org/pub/nspr/releases/v${MCHS_PKG_VERSION}/src/nspr-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b23ee315be0e50c2fb1aa374d17f2d2d9146a835b1a79c1918ea15d075a693d7
MCHS_PKG_HOSTBUILD=true

mchs_step_post_get_source() {
	MCHS_PKG_SRCDIR+="/nspr"
}

mchs_step_pre_configure() {
	CPPFLAGS+=" -DANDROID"
	LDFLAGS+=" -llog"

	if [ $MCHS_ARCH_BITS -eq 64 ]; then
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-64bit"
	fi

	MCHS_PKG_EXTRA_MAKE_ARGS+="
		NSINSTALL=$MCHS_PKG_HOSTBUILD_DIR/config/nsinstall
		NOW=$MCHS_PKG_HOSTBUILD_DIR/config/now
		"
}
