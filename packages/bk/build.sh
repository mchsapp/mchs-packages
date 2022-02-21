MCHS_PKG_HOMEPAGE=https://github.com/aeosynth/bk
MCHS_PKG_DESCRIPTION="A terminal EPUB reader"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.3
# Whenever the next release happens, we can change to git release tarball.
_COMMIT=61beded518e759884d72732a068744935c11ea6f
MCHS_PKG_SRCURL=https://github.com/aeosynth/bk/archive/$_COMMIT.zip
MCHS_PKG_SHA256=c8d738eaf56684fcaeda9c46549e0f024801805d82cf31542a35c007faf07085
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_setup_rust
}

mchs_step_make() {
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/bk
}
