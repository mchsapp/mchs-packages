MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gforth/
MCHS_PKG_DESCRIPTION="The Forth implementation of the GNU project"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.3
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/gforth/gforth-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2f62f2233bf022c23d01c920b1556aa13eab168e3236b13352ac5e9f18542bb0
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file___arch_386_asm_fs=yes
ac_cv_file___arch_386_disasm_fs=yes
ac_cv_file___arch_amd64_asm_fs=yes
ac_cv_file___arch_amd64_disasm_fs=yes
ac_cv_file___arch_arm_asm_fs=no
ac_cv_file___arch_arm_disasm_fs=no
ac_cv_file___arch_generic_asm_fs=no
ac_cv_file___arch_generic_disasm_fs=no
ac_cv_func_memcmp_working=yes
skipcode=no
--without-check
"
MCHS_MAKE_PROCESSES=1
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	_PREFIX_FOR_BUILD=$MCHS_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	find $MCHS_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	./configure --prefix=$_PREFIX_FOR_BUILD CC="gcc -m$MCHS_ARCH_BITS"
	make -j $MCHS_MAKE_PROCESSES
	make install
}

mchs_step_pre_configure() {
	PATH=$MCHS_PKG_HOSTBUILD_DIR/prefix/bin:$PATH
}

mchs_step_post_configure() {
	sed -i -e 's:\.\(/gforth-ditc\):'$MCHS_PKG_HOSTBUILD_DIR'\1:g' \
		Makefile
}
