MCHS_PKG_HOMEPAGE=https://github.com/sharkdp/pastel
MCHS_PKG_DESCRIPTION="A command-line tool to generate, analyze, convert and manipulate colors"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
MCHS_PKG_MAINTAINER="Yaksh Bariya <yakshbari4@gmail.com>"
MCHS_PKG_VERSION=0.8.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/sharkdp/pastel/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e1afcd8035a4c1da7f6d0fc8d5fc703dee72baa77bd0588a67d3b606e70146cb
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_setup_rust
}

mchs_step_make() {
	SHELL_COMPLETIONS_DIR=$MCHS_PKG_BUILDDIR/completions cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/pastel

	# Install completions
	install -Dm600 $MCHS_PKG_BUILDDIR/completions/_pastel \
		$MCHS_PREFIX/share/zsh/site-functions/_pastel
	install -Dm600 $MCHS_PKG_BUILDDIR/completions/pastel.bash \
		$MCHS_PREFIX/share/bash-completion/completions/pastel.bash
	install -Dm600 $MCHS_PKG_BUILDDIR/completions/pastel.fish \
		$MCHS_PREFIX/share/fish/vendor_completions.d/pastel.fish
}
