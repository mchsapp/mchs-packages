MCHS_PKG_HOMEPAGE=https://github.com/kak-lsp/kak-lsp
MCHS_PKG_DESCRIPTION="Language Server Protocol Client for the Kakoune editor"
MCHS_PKG_LICENSE="MIT, Unlicense"
MCHS_PKG_MAINTAINER="@buttaface"
MCHS_PKG_VERSION=12.0.1
MCHS_PKG_SRCURL=https://github.com/kak-lsp/kak-lsp/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=37b54186f7f18d879c605cb235452a92308361676fc3966c2e65bbaae30b7a3e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm Makefile
}

mchs_step_post_make_install() {
	rm -rf $MCHS_PREFIX/share/kak-lsp
	mkdir -p $MCHS_PREFIX/share/kak-lsp/examples
	cp $MCHS_PKG_SRCDIR/kak-lsp.toml $MCHS_PREFIX/share/kak-lsp/examples
	cp -r $MCHS_PKG_SRCDIR/rc $MCHS_PREFIX/share/kak-lsp
}
