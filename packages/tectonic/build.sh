MCHS_PKG_HOMEPAGE=https://tectonic-typesetting.github.io/
MCHS_PKG_DESCRIPTION="A modernized, complete, self-contained TeX/LaTeX engine"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.0
MCHS_PKG_SRCURL=https://github.com/tectonic-typesetting/tectonic.git
MCHS_PKG_GIT_BRANCH=tectonic@${MCHS_PKG_VERSION}
MCHS_PKG_DEPENDS="fontconfig, harfbuzz, libgraphite, libicu, openssl, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/tectonic
}
