MCHS_PKG_HOMEPAGE=https://bellard.org/tcc/
MCHS_PKG_DESCRIPTION="Tiny C Compiler"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:0.9.27
MCHS_PKG_REVISION=10
MCHS_PKG_SRCURL=https://repo.or.cz/tinycc.git/snapshot/fef838db2d124db3f1357385972371ccba7af2c6.tar.gz
MCHS_PKG_SHA256=f6a022994b9903485a1777540c0c9e0571990fc339a2b325be6127b616534f33
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_NO_STATICSPLIT=true

mchs_step_configure() {
	unset CFLAGS CXXFLAGS

	if [ "${MCHS_ARCH}" = "arm" ] || [ "${MCHS_ARCH}" = "i686" ]; then
		ELF_INTERPRETER_PATH="/system/bin/linker"
		ANDROID_LIB_PATH="/system/lib:/system/vendor/lib"
	else
		ELF_INTERPRETER_PATH="/system/bin/linker64"
		ANDROID_LIB_PATH="/system/lib64:/system/vendor/lib64"
	fi
}

mchs_step_make() {
	(
		unset CC CFLAGS LDFLAGS
		./configure --prefix="/tmp/tcc.host" --cpu="${MCHS_ARCH}"
		make -j $MCHS_MAKE_PROCESSES tcc
		mv -f tcc tcc.host
		make distclean
	)

	./configure \
		--prefix="$MCHS_PREFIX" \
		--cross-prefix="${CC//clang}" \
		--cc="clang" \
		--cpu="$MCHS_ARCH" \
		--disable-rpath \
		--elfinterp="$ELF_INTERPRETER_PATH" \
		--crtprefix="$MCHS_PREFIX/lib/tcc/crt" \
		--sysincludepaths="$MCHS_PREFIX/include:$MCHS_PREFIX/lib/tcc/include" \
		--libpaths="$MCHS_PREFIX/lib:$MCHS_PREFIX/lib/tcc:$ANDROID_LIB_PATH"

	mv tcc.host tcc
	touch -d "next minute" tcc
	make -j ${MCHS_MAKE_PROCESSES} libtcc1.a

	rm -f tcc
	make -j ${MCHS_MAKE_PROCESSES} tcc

	make install

	for file in crtbegin_dynamic.o crtbegin_so.o crtend_android.o crtend_so.o; do
		install -Dm600 \
			"${MCHS_STANDALONE_TOOLCHAIN}/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/$file" \
			"${MCHS_PREFIX}/lib/tcc/crt/$file"
	done
}
