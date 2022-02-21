MCHS_PKG_HOMEPAGE=https://github.com/kaegi/alass
MCHS_PKG_DESCRIPTION="Automatic Language-Agnostic Subtitle Synchronization"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.0
MCHS_PKG_SRCURL="https://github.com/kaegi/alass/archive/v$MCHS_PKG_VERSION.tar.gz"
MCHS_PKG_SHA256=ce88f92c7a427b623edcabb1b64e80be70cca2777f3da4b96702820a6cdf1e26
MCHS_PKG_DEPENDS="ffmpeg"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm -f Makefile
}

mchs_step_make_install() {
    mchs_setup_rust
    cargo install \
        --jobs $MCHS_MAKE_PROCESSES \
        --path alass-cli \
        --force \
        --locked \
        --target $CARGO_TARGET_NAME \
        --root $MCHS_PREFIX \
        $MCHS_PKG_EXTRA_CONFIGURE_ARGS
    # https://github.com/rust-lang/cargo/issues/3316:
    rm -f $MCHS_PREFIX/.crates.toml
    rm -f $MCHS_PREFIX/.crates2.json
}

mchs_step_post_make_install() {
    install -Dm644 LICENSE "$MCHS_PREFIX/share/licenses/alass/LICENSE"
}
