MCHS_PKG_HOMEPAGE=https://github.com/sytsereitsma/mdbook-plantuml
MCHS_PKG_DESCRIPTION="mdBook preprocessor to render PlantUML code blocks as images in your book"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.0
MCHS_PKG_SRCURL=https://github.com/sytsereitsma/mdbook-plantuml.git
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$MCHS_PREFIX/include/openssl
	export OPENSSL_LIB_DIR=$MCHS_PREFIX/lib
}

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-plantuml
}
