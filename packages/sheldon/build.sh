MCHS_PKG_HOMEPAGE=https://github.com/rossmacarthur/sheldon
MCHS_PKG_DESCRIPTION="Fast, configurable, shell plugin manager"
MCHS_PKG_LICENSE="MIT, Apache-2.0"
MCHS_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6.6
MCHS_PKG_SRCURL=https://github.com/rossmacarthur/sheldon/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9d6cdc8fe011c4defe65fbe1507e48a51f8efdeebb5d5b0b39fbde2c73566973
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t "${MCHS_PREFIX}"/bin target/${CARGO_TARGET_NAME}/release/sheldon

	# completions
	install -Dm644 completions/sheldon.bash "${MCHS_PREFIX}/share/bash-completion/completions/sheldon"
	install -Dm644 completions/sheldon.zsh "${MCHS_PREFIX}/share/zsh/site-functions/_sheldon"
}
