MCHS_PKG_HOMEPAGE="https://helix-editor.com/"
MCHS_PKG_DESCRIPTION="A post-modern modal text editor written in rust"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="MrAdityaAlok <dev.aditya.alok@gmail.com>"
MCHS_PKG_VERSION=0.6.0
MCHS_PKG_SRCURL="https://github.com/helix-editor/helix.git"
MCHS_PKG_GIT_BRANCH="v$MCHS_PKG_VERSION"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	mchs_setup_rust

	sed -i "s%\@MCHS_CC\@%${CC}%g" ./helix-syntax/build.rs

	cargo build --jobs "${MCHS_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release

	cat >"hx" <<-EOF
		#!${MCHS_PREFIX}/bin/sh

		HELIX_RUNTIME=${MCHS_PREFIX}/lib/helix/runtime \\
		exec ${MCHS_PREFIX}/lib/helix/hx "\$@"
	EOF
	install -Dm744 ./hx "${MCHS_PREFIX}/bin/hx"

	install -Dm744 -t "${MCHS_PREFIX}"/lib/helix target/"${CARGO_TARGET_NAME}"/release/hx
	install -Dm644 -t "${MCHS_PREFIX}"/lib/helix languages.toml

	cp -r runtime "${MCHS_PREFIX}/lib/helix"
}
