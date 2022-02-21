MCHS_PKG_HOMEPAGE=http://www.gnu.org/software/guile/
MCHS_PKG_DESCRIPTION="Portable, embeddable Scheme implementation written in C"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2.7
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/guile/guile-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=44b4c5fbbe257ccdebea18420212c9b3e90c3c86a54920d8554039fc6769a007
MCHS_PKG_DEPENDS="libandroid-support, libffi, libgc, libgmp, libltdl, libunistring"
MCHS_PKG_BUILD_DEPENDS="libtool"
MCHS_PKG_BREAKS="guile-dev"
MCHS_PKG_REPLACES="guile-dev"
MCHS_PKG_CONFLICTS="guile18"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_type_complex_double=no ac_cv_search_clock_getcpuclockid=false ac_cv_func_GC_move_disappearing_link=yes ac_cv_func_GC_is_heap_ptr=yes"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	mkdir HOSTBUILDINSTALL

	../src/configure --prefix=$MCHS_PKG_HOSTBUILD_DIR/HOSTBUILDINSTALL # CFLAGS="-m32" LDFLAGS=" -L/usr/lib/i386-linux-gnu" --host=i386-linux-gnu
	make -j $MCHS_MAKE_PROCESSES
	make install
}

mchs_step_pre_configure() {

	export GUILE_FOR_BUILD="$MCHS_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL/bin/guile
	export LD_LIBRARY_PATH="$MCHS_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL/lib
}

mchs_step_post_massage() {
        sed -i 's',"$MCHS_STANDALONE_TOOLCHAIN/bin/$MCHS_HOST_PLATFORM-pkg-config","$MCHS_PREFIX/bin/pkg-config",'g' $MCHS_PKG_MASSAGEDIR$MCHS_PREFIX/bin/guile-config
}                              
