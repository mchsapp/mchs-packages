MCHS_PKG_HOMEPAGE=https://www.ginac.de/CLN/
MCHS_PKG_DESCRIPTION="CLN is a library for efficient computations with all kinds of numbers in arbitrary precision"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.6
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://www.ginac.de/CLN/cln-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=f492530e8879bda529009b6033e1923c8f4aae843149fc28c667c20b094d984a
MCHS_PKG_DEPENDS="libc++, libgmp"
MCHS_PKG_BREAKS="libcln-dev"
MCHS_PKG_REPLACES="libcln-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = arm ]; then
		# See the following section in INSTALL:
		# "(*) On these platforms, problems with the assembler routines have been
		# reported. It may be best to add "-DNO_ASM" to CPPFLAGS before configuring."
		CPPFLAGS+=" -DNO_ASM"
		CXXFLAGS+=" -fintegrated-as"
	fi

	sed -i -e 's%tests/Makefile %%' configure.ac
	sed -i -e 's%examples/Makefile %%' configure.ac
	sed -i -e 's%benchmarks/Makefile %%' configure.ac

	autoreconf
}

mchs_step_post_configure() {
	cd $MCHS_PKG_SRCDIR
	sed -i -e 's% tests%%' Makefile
	sed -i -e 's% examples%%' Makefile
	sed -i -e 's% benchmarks%%' Makefile

	sed -i -e '/^#error /d' \
		-e 's/^\(#define int_bitsize\) .*$/\1 32/' \
		-e 's/^\(#define long_bitsize\) .*$/\1 '$MCHS_ARCH_BITS'/' \
		-e 's/^\(#define long_long_bitsize\) .*$/\1 64/' \
		include/cln/intparam.h
}
