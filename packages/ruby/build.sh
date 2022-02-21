MCHS_PKG_HOMEPAGE=https://www.ruby-lang.org/
MCHS_PKG_DESCRIPTION="Dynamic programming language with a focus on simplicity and productivity"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1.0
MCHS_PKG_SRCURL=https://cache.ruby-lang.org/pub/ruby/${MCHS_PKG_VERSION:0:3}/ruby-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=1a0e0b69b9b062b6299ff1f6c6d77b66aff3995f63d1d8b8771e7a113ec472e2
# libbffi is used by the fiddle extension module:
MCHS_PKG_DEPENDS="libandroid-support, libffi, libgmp, readline, openssl, libyaml, zlib"
MCHS_PKG_RECOMMENDS="clang, make, pkg-config"
MCHS_PKG_BREAKS="ruby-dev"
MCHS_PKG_REPLACES="ruby-dev"
# Needed to fix compilation on android:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setgroups=no ac_cv_func_setresuid=no ac_cv_func_setreuid=no --enable-rubygems"
# Do not link in libcrypt.so if available (now in disabled-packages):
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
# Fix DEPRECATED_TYPE macro clang compatibility:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" rb_cv_type_deprecated=x"
# getresuid(2) does not work on ChromeOS - https://github.com/mchs/mchs-app/issues/147:
# MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getresuid=no"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	"$MCHS_PKG_SRCDIR/configure" --prefix=$MCHS_PKG_HOSTBUILD_DIR/ruby-host
	make -j $MCHS_MAKE_PROCESSES
	make install
}

mchs_step_pre_configure() {
	export PATH=$MCHS_PKG_HOSTBUILD_DIR/ruby-host/bin:$PATH

	if [ "$MCHS_ARCH_BITS" = 32 ]; then
		# process.c:function timetick2integer: error: undefined reference to '__mulodi4'
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" rb_cv_builtin___builtin_mul_overflow=no"
	fi

	# Do not remove: fix for Clang's "overoptimization".
	CFLAGS+=" -fno-strict-aliasing"
}

mchs_step_make_install() {
	make install
	make uninstall # remove possible remains to get fresh timestamps
	make install

	local RBCONFIG=$MCHS_PREFIX/lib/ruby/${MCHS_PKG_VERSION:0:3}.0/${MCHS_HOST_PLATFORM}/rbconfig.rb

	# Fix absolute paths to executables:
	perl -p -i -e 's/^.*CONFIG\["INSTALL"\].*$/  CONFIG["INSTALL"] = "install -c"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["PKG_CONFIG"\].*$/  CONFIG["PKG_CONFIG"] = "pkg-config"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["MAKEDIRS"\].*$/  CONFIG["MAKEDIRS"] = "mkdir -p"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["MKDIR_P"\].*$/  CONFIG["MKDIR_P"] = "mkdir -p"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["EGREP"\].*$/  CONFIG["EGREP"] = "grep -E"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["GREP"\].*$/  CONFIG["GREP"] = "grep"/' $RBCONFIG
}

mchs_step_post_massage() {
	if [ ! -f $MCHS_PREFIX/lib/ruby/${MCHS_PKG_VERSION:0:3}.0/${MCHS_HOST_PLATFORM}/readline.so ]; then
		echo "Error: The readline extension was not built"
	fi
}
