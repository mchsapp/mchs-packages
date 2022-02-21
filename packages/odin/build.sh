MCHS_PKG_HOMEPAGE=https://odin-lang.org/
MCHS_PKG_DESCRIPTION="The Odin programming language"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2022.01
MCHS_PKG_SRCURL=https://github.com/odin-lang/Odin/archive/refs/tags/dev-${MCHS_PKG_VERSION//./-}.tar.gz
MCHS_PKG_SHA256=44fcae303462f95b042423e93f08e096b14a55f2db1cfcf3d6b5a64f10621833
MCHS_PKG_DEPENDS="libiconv, libllvm"

# ```
# [...]/src/gb/gb.h:6754:2: error: "gb_rdtsc not supported"
# #error "gb_rdtsc not supported"
#  ^
# ```
MCHS_PKG_BLACKLISTED_ARCHES="arm"

mchs_step_pre_configure() {
	if [ "$MCHS_PKG_API_LEVEL" -lt 28 ]; then
		CPPFLAGS+=" -Daligned_alloc=memalign"
	fi
	LDFLAGS+=" -lLLVM -liconv"
}

mchs_step_make() {
	for s in src/main.cpp src/libtommath.cpp; do
		$CXX $CPPFLAGS $CXXFLAGS -c $MCHS_PKG_SRCDIR/$s
	done
	$CXX $CXXFLAGS main.o libtommath.o -o odin $LDFLAGS
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin odin
}
