MCHS_PKG_HOMEPAGE=https://github.com/jhspetersson/fselect
MCHS_PKG_DESCRIPTION="Find files with SQL-like queries"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.0
MCHS_PKG_SRCURL=https://github.com/jhspetersson/fselect/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=33dfcbbf7e598bce479b1fb5c17429af1bb309beab2e4bc95642e9f4b5c2ffbd
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_make_install() {
	install -Dm700 \
		"$MCHS_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/fselect \
		"$MCHS_PREFIX"/bin/fselect
}
