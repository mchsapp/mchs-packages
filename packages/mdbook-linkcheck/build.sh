MCHS_PKG_HOMEPAGE=https://michael-f-bryan.github.io/mdbook-linkcheck/
MCHS_PKG_DESCRIPTION="A backend for mdbook which will check your links for you"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.6
MCHS_PKG_SRCURL=https://github.com/Michael-F-Bryan/mdbook-linkcheck.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH" == "i686" ]; then
		local libdir=target/i686-linux-android/release/deps
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
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-linkcheck
}
