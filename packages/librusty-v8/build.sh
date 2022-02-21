MCHS_PKG_HOMEPAGE=https://github.com/denoland/rusty_v8
MCHS_PKG_DESCRIPTION="High quality Rust bindings to V8's C++ API"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=8b90dfd2f4fcbbaefd2c4d2be220d94a00a3ebba
MCHS_PKG_VERSION=2022.02.02
MCHS_PKG_SRCURL=https://github.com/denoland/rusty_v8.git
MCHS_PKG_GIT_BRANCH=main
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_NO_STATICSPLIT=true
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

mchs_step_post_get_source() {
	git fetch --unshallow || true
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$MCHS_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$MCHS_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	git submodule update --init --recursive
}

mchs_step_pre_configure() {
	export V8_FROM_SOURCE=1
	export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
}

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm600 -t $MCHS_PREFIX/lib \
		target/$CARGO_TARGET_NAME/release/gn_out/obj/librusty_v8.a
}

mchs_step_post_make_install() {
	unset V8_FROM_SOURCE
	unset PKG_CONFIG_PATH
}
