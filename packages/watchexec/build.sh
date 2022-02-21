MCHS_PKG_HOMEPAGE=https://github.com/watchexec/watchexec
MCHS_PKG_DESCRIPTION="Executes commands in response to file modifications"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.17.1
MCHS_PKG_SRCURL=https://github.com/watchexec/watchexec/archive/cli-v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=3bc82174729628010d29c85f2d2c61cc45cef5cc729f13153b1422c8f647d33f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
    mchs_setup_rust
    cargo install \
        --jobs $MCHS_MAKE_PROCESSES \
        --path cli \
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
    install -Dm644 -t "$MCHS_PREFIX"/share/doc/watchexec/watchexec.1.html \
        "$MCHS_PKG_SRCDIR"/doc/watchexec.1.html
    install -Dm644 -t "$MCHS_PREFIX"/share/man/man1/watchexec.1 \
        "$MCHS_PKG_SRCDIR"/doc/watchexec.1
    install -Dm644 "completions/zsh" \
        "$MCHS_PREFIX/share/zsh/site-functions/_watchexec"
    install -Dm644 LICENSE "$MCHS_PREFIX/share/licenses/watchexec/LICENSE"
}
