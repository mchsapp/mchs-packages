MCHS_PKG_HOMEPAGE=https://github.com/cantino/mcfly
MCHS_PKG_DESCRIPTION="Replaces your default ctrl-r shell history search with an intelligent search engine"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.12
MCHS_PKG_SRCURL=https://github.com/cantino/mcfly/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=41bbcbde13c3a27696cb4ac0b9e752a925661747acc4075450e10d4e17b17bde
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH" == "x86_64" ]; then
		local libdir=target/x86_64-linux-android/release/deps
		mkdir -p $libdir
		pushd $libdir
		local libgcc="$($CC -print-libgcc-file-name)"
		echo "INPUT($libgcc -l:libunwind.a)" > libgcc.so
		popd
	fi
}

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mcfly
	install -Dm600 -t $MCHS_PREFIX/share/mcfly mcfly.{ba,fi,z}sh
}
