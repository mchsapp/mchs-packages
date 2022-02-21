MCHS_PKG_HOMEPAGE=https://github.com/phiresky/ripgrep-all
MCHS_PKG_DESCRIPTION="Search tool able to locate in PDFs, E-Books, zip, tar.gz, etc"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
MCHS_PKG_VERSION=0.9.6
MCHS_PKG_REVISION=2
MCHS_PKG_DEPENDS="ripgrep, fzf"
MCHS_PKG_RECOMMENDS="ffmpeg, poppler, sqlite"
MCHS_PKG_SRCURL=https://github.com/phiresky/ripgrep-all/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8cd7c5d13bd90ef0582168cd2bef73ca13ca6e0b1ecf24b9a5cd7cb886259023
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	mchs_setup_rust
	
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rga
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rga-preproc
	install -m755 $MCHS_PKG_BUILDER_DIR/rga-fzf  $MCHS_PREFIX/bin/rga-fzf
}
