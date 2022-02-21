MCHS_PKG_HOMEPAGE=https://github.com/denisidoro/navi
MCHS_PKG_DESCRIPTION="An interactive cheatsheet tool for the command-line"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.19.0
MCHS_PKG_SRCURL=https://github.com/denisidoro/navi/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=dfcefd8deb4c472517640e5ff285ec9f8cfc54546e6616917bfd8d6bc0f2e086
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="fzf, git"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm -f Makefile
}

mchs_step_make_install() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/navi
}
