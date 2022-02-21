MCHS_PKG_HOMEPAGE=https://lfortran.org/
MCHS_PKG_DESCRIPTION="A modern open-source interactive Fortran compiler"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.14.0
MCHS_PKG_SRCURL=https://gitlab.com/lfortran/lfortran.git
MCHS_PKG_DEPENDS="clang, libc++, libkokkos, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"
MCHS_PKG_HOSTBUILD=true

# ```
# [...]/src/lfortran/parser/parser_stype.h:97:1: error: static_assert failed
# due to requirement
# 'sizeof(LFortran::YYSTYPE) == sizeof(LFortran::Vec<LFortran::AST::ast_t *>)'
# static_assert(sizeof(YYSTYPE) == sizeof(Vec<AST::ast_t*>));
# ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ```
# Furthermore libkokkos does not support ILP32
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_host_build() {
	mchs_setup_cmake

	( cd $MCHS_PKG_SRCDIR && sh build0.sh )
	cmake $MCHS_PKG_SRCDIR
	make -j $MCHS_MAKE_PROCESSES
}

mchs_step_pre_configure() {
	PATH=$MCHS_PKG_HOSTBUILD_DIR/src/bin:$PATH

	( cd $MCHS_PKG_SRCDIR && sh build0.sh )

	for f in fpmath.h math_private.h s_clog.c s_clogf.c s_cpowf.c; do
		cp $MCHS_PKG_BUILDER_DIR/$f $MCHS_PKG_SRCDIR/src/runtime/impure/
	done

	LDFLAGS+=" -lm"
}
