MCHS_PKG_HOMEPAGE=https://www.erlang.org/
MCHS_PKG_DESCRIPTION="General-purpose concurrent functional programming language"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=24.2.1
MCHS_PKG_SRCURL=https://github.com/erlang/otp/archive/OTP-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=2854318d12d727fc508e8fd5fe6921c0cbc7727d1183ad8f6f808585496e42d6
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+(\.\d+)+"
MCHS_PKG_DEPENDS="openssl, ncurses, zlib"
MCHS_PKG_NO_STATICSPLIT=true
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--without-javac
--with-ssl=${MCHS_PREFIX}
--with-termcap
erl_xcomp_sysroot=${MCHS_PREFIX}
"

mchs_step_post_get_source() {
	# We need a host build every time, because we dont know the full output of host build and have no idea to cache it.
	rm -Rf "$MCHS_PKG_HOSTBUILD_DIR"
}

mchs_step_host_build() {
	cd $MCHS_PKG_BUILDDIR
	# Erlang cross compile reference: https://github.com/erlang/otp/blob/master/HOWTO/INSTALL-CROSS.md#building-a-bootstrap-system
	# Build erlang bootstrap system.
	./configure --enable-bootstrap-only --without-javac --without-ssl --without-termcap
	make -j $MCHS_MAKE_PROCESSES
}

mchs_step_pre_configure() {
	# Add --build flag for erlang cross build
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --build=$(./erts/autoconf/config.guess)"
}