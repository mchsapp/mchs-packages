MCHS_PKG_HOMEPAGE=https://github.com/badboy/mdbook-mermaid
MCHS_PKG_DESCRIPTION="A preprocessor for mdbook to add mermaid support"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.3
MCHS_PKG_SRCURL=https://github.com/badboy/mdbook-mermaid.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-mermaid
}
