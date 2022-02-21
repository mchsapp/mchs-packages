MCHS_PKG_HOMEPAGE=https://github.com/bettio/AtomVM
MCHS_PKG_DESCRIPTION="The minimal Erlang VM implementation"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=82624fbf68ad8a0c8815456adbd33de98e4901ea
MCHS_PKG_VERSION=0.git${_COMMIT:0:8}
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=https://github.com/bettio/AtomVM/archive/${_COMMIT}.tar.gz
MCHS_PKG_SHA256=b141812be3fe157766464b8fcedc13f40b36bc9346b3e039ac736c5d30359729
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	mchs_setup_cmake
	cmake "$MCHS_PKG_SRCDIR"
	make -j $MCHS_MAKE_PROCESSES
}

mchs_step_post_configure() {
	# We need the "PackBEAM" compiled for host.
	export PATH=$PATH:$MCHS_PKG_HOSTBUILD_DIR/tools/packbeam
}

mchs_step_make_install() {
	install -Dm700 "$MCHS_PKG_BUILDDIR"/src/AtomVM \
		"$MCHS_PREFIX"/bin/AtomVM
	install -Dm700 "$MCHS_PKG_BUILDDIR"/tools/packbeam/PackBEAM \
		"$MCHS_PREFIX"/bin/PackBEAM
}
