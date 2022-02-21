MCHS_PKG_HOMEPAGE=https://mruby.org/
MCHS_PKG_DESCRIPTION="Lightweight implementation of the Ruby language"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.0.0
MCHS_PKG_SRCURL=https://github.com/mruby/mruby/archive/${MCHS_PKG_VERSION}.zip
MCHS_PKG_SHA256=c7d95fdc05efdc8f5a0df4d5f0fbad5092596d61927c39515d03b8dde4743a8e
MCHS_PKG_DEPENDS="ncurses, readline"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	:
}

mchs_step_make() {
	export CC_FOR_TARGET="$CC"
	export CFLAGS_FOR_TARGET="$CPPFLAGS $CFLAGS -DMRB_USE_READLINE"
	export LDFLAGS_FOR_TARGET="$LDFLAGS -lncurses -lreadline"
	unset CPPFLAGS CFLAGS LDFLAGS
	export CC="$CC_FOR_BUILD"
	export LD="$CC_FOR_BUILD"

	export ANDROID_NDK_HOME="$NDK"
	export MRUBY_CONFIG=android-mchs
	rake
}

mchs_step_make_install() {
	cd "$MCHS_PKG_BUILDDIR/build/android-mchs"
	for f in bin/*; do
		install -Dm700 -t $MCHS_PREFIX/bin $f
	done
	for f in lib/*.a; do
		install -Dm600 -t $MCHS_PREFIX/lib $f
	done
	cp -a "$MCHS_PKG_SRCDIR/include" $MCHS_PREFIX/
}
