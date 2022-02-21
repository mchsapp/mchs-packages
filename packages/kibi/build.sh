MCHS_PKG_HOMEPAGE=https://github.com/ilai-deutel/kibi
MCHS_PKG_DESCRIPTION="A tiny terminal text editor, written in Rust"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_MAINTAINER="Ilaï Deutel @ilai-deutel"
MCHS_PKG_VERSION=0.2.2
MCHS_PKG_SRCURL=https://github.com/ilai-deutel/kibi/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=df0e2945d9d08fed3a0adbe73c73405641615eb55835675e06e91411fd541e91
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_make_install() {
    install -Dm644 "config_example.ini" "$MCHS_PREFIX/etc/kibi/config.ini"
    install -Dm644 syntax.d/* -t "$MCHS_PREFIX/share/kibi/syntax.d"
}
