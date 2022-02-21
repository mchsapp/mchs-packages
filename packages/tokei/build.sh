MCHS_PKG_HOMEPAGE=https://github.com/XAMPPRocky/tokei
MCHS_PKG_DESCRIPTION="A blazingly fast CLOC (Count Lines Of Code) program"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=12.1.2
MCHS_PKG_SRCURL=https://github.com/XAMPPRocky/tokei/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=81ef14ab8eaa70a68249a299f26f26eba22f342fb8e22fca463b08080f436e50
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--features all"

mchs_step_post_make_install() {
	install -Dm700 \
		"$MCHS_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/tokei \
		"$MCHS_PREFIX"/bin/tokei
}
