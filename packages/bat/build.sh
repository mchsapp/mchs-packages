MCHS_PKG_HOMEPAGE=https://github.com/sharkdp/bat
MCHS_PKG_DESCRIPTION="A cat(1) clone with wings"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.19.0
MCHS_PKG_SRCURL=https://github.com/sharkdp/bat/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6a920cad1e7ae069eb9393f5b6883e0a7f2c957186b1075976331daaa5e0468a
MCHS_PKG_AUTO_UPDATE=true
# bat calls less with '--RAW-CONTROL-CHARS' which busybox less does not support:
MCHS_PKG_DEPENDS="less, libgit2"
MCHS_PKG_BUILD_IN_SRC=true
mchs_step_pre_configure() {
	CFLAGS="$CFLAGS $CPPFLAGS"

	# See https://github.com/nagisa/rust_libloading/issues/54
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu=""
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/share/man/man1
	cp $(find . -name bat.1) $MCHS_PREFIX/share/man/man1/
}
