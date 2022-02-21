MCHS_PKG_HOMEPAGE=https://github.com/lzanini/mdbook-katex
MCHS_PKG_DESCRIPTION="A preprocessor for mdBook, pre-rendering LaTex equations to HTML at build time"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=a16a13f4358cf67db5570ecff5e1002578c161d5
_COMMIT_DATE=2022.01.27
MCHS_PKG_VERSION=0.2.10p${_COMMIT_DATE//./}
MCHS_PKG_SRCURL=https://github.com/lzanini/mdbook-katex.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

mchs_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$MCHS_PREFIX/include/openssl
	export OPENSSL_LIB_DIR=$MCHS_PREFIX/lib
}

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-katex
}
