MCHS_PKG_HOMEPAGE=https://github.com/rui314/mold
MCHS_PKG_DESCRIPTION="mold: A Modern Linker"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=ce744aeca423954c9152a6c1c2185f149bf50ad8
MCHS_PKG_VERSION=1.0.3.20220212
MCHS_PKG_SRCURL=https://github.com/rui314/mold.git
MCHS_PKG_GIT_BRANCH=main
MCHS_PKG_DEPENDS="libc++, openssl, zlib, libandroid-spawn"
MCHS_PKG_BUILD_IN_SRC=true

mchs_post_get_source() {
	git fetch --unshallow
	git reset --hard ${_COMMIT}
}

mchs_step_pre_configure() {
	# onetbb use cmake
	mchs_setup_cmake
}

mchs_step_make() {
	# Have to override Makefile variables here
	# else need to patch Makefile
	# When building mold-wrapper.so cant find
	# spawn.h from libandroid-spawn for some reason
	# Manually link just in case to avoid runtime surprises
	make -j ${MCHS_MAKE_PROCESSES} \
		PREFIX="${MCHS_PREFIX}" \
		CFLAGS="${CFLAGS} -I${MCHS_PREFIX}/include" \
		CXXFLAGS="${CXXFLAGS}" \
		STRIP="${STRIP}" \
		MOLD_WRAPPER_LDFLAGS=" -ldl -landroid-spawn"
}

mchs_step_make_install() {
	make -j 1 install \
		PREFIX="${MCHS_PREFIX}" \
		CFLAGS="${CFLAGS} -I${MCHS_PREFIX}/include" \
		CXXFLAGS="${CXXFLAGS}" \
		STRIP="${STRIP}" \
		MOLD_WRAPPER_LDFLAGS=" -ldl -landroid-spawn"
}
