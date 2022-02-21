MCHS_PKG_HOMEPAGE=https://texlab.netlify.app/
MCHS_PKG_DESCRIPTION="A cross-platform implementation of the Language Server Protocol providing rich cross-editing support for the LaTeX typesetting system"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.3.1
MCHS_PKG_SRCURL=https://github.com/latex-lsp/texlab.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/texlab
}
