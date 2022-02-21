MCHS_PKG_HOMEPAGE=https://deno.land/
MCHS_PKG_DESCRIPTION="A modern runtime for JavaScript and TypeScript"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=1259a3f48c00e95a8bb0964e4dabfa769a20bcde
_COMMIT_DATE=2022.01.19
MCHS_PKG_VERSION=1.17.3p${_COMMIT_DATE//./}
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/denoland/deno.git
MCHS_PKG_GIT_BRANCH=main
MCHS_PKG_DEPENDS="libffi"
#MCHS_PKG_BUILD_DEPENDS="librusty-v8"
MCHS_PKG_BUILD_IN_SRC=true

# Due to dependency on librusty-v8.
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	git submodule update --init --recursive
}

mchs_step_pre_configure() {
	mchs_setup_rust

	if [ "$MCHS_DEBUG_BUILD" = "true" ]; then
		BUILD_TYPE=debug
	else
		BUILD_TYPE=release
	fi
}

mchs_step_make() {
	local libdir=target/$CARGO_TARGET_NAME/$BUILD_TYPE/deps
	mkdir -p $libdir
	ln -sf $MCHS_PREFIX/lib/libffi.so $libdir/
	local libgcc="$($CC -print-libgcc-file-name)"
	echo "INPUT($libgcc -l:libunwind.a)" > $libdir/libgcc.so
	local cmd="cargo build --jobs $MCHS_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME"
	if [ "$MCHS_DEBUG_BUILD" = "false" ]; then
		cmd+=" --release"
	fi
	#$cmd || :
	#ln -sf $MCHS_PREFIX/lib/librusty_v8.a \
	#	target/$CARGO_TARGET_NAME/release/gn_out/obj/librusty_v8.a
	$cmd
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/$BUILD_TYPE/deno
}
