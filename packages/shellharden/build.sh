MCHS_PKG_HOMEPAGE=https://github.com/anordal/shellharden
MCHS_PKG_DESCRIPTION="The corrective bash syntax highlighter"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.1.2
MCHS_PKG_SRCURL=https://github.com/anordal/shellharden/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=8e5f623f9d58e08460d3ecabb28c53f1969bed09c2526f01b5e00362a8b08e7f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_make_install() {
	install -Dm700 \
		"$MCHS_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/shellharden \
		"$MCHS_PREFIX"/bin/
}
