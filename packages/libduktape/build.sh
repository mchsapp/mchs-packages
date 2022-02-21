MCHS_PKG_HOMEPAGE=https://www.duktape.org/
MCHS_PKG_DESCRIPTION="An embeddable Javascript engine with a focus on portability and compact footprint"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_SRCURL=https://github.com/svaarala/duktape.git
MCHS_PKG_VERSION=2.6.0
MCHS_PKG_REVISION=1
MCHS_PKG_REPLACES="duktape (<< 2.3.0-1), libduktape-dev"
MCHS_PKG_BREAKS="duktape (<< 2.3.0-1), libduktape-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	# configure.py requires 'yaml' python2 module.
	if ! pip2 show pyyaml > /dev/null 2>&1; then
		pip2 install pyyaml
	fi
}

mchs_step_make() {
	make libduktape.so.1.0.0 duk CC=${CC} GXX=${CXX}
}

mchs_step_make_install() {
	install libduktape.so.1.0.0 ${MCHS_PREFIX}/lib/libduktape.so
	install duk ${MCHS_PREFIX}/bin
	install prep/nondebug/*.h ${MCHS_PREFIX}/include
}

mchs_step_post_make_install() {
	# Add a pkg-config file for the duktape lib
	mkdir -p "$PKG_CONFIG_LIBDIR"
	cat > "$PKG_CONFIG_LIBDIR/duktape.pc" <<-HERE
		Name: Duktape
		Description: Shared library for the Duktape interpreter
		Version: $MCHS_PKG_VERSION
		Requires:
		Libs: -lduktape -lm
	HERE
}
