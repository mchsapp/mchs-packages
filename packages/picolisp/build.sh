MCHS_PKG_HOMEPAGE=https://picolisp.com/wiki/?home
MCHS_PKG_DESCRIPTION="Lisp interpreter and application server framework"
MCHS_PKG_LICENSE="MIT"
# MCHS_PKG_SRCDIR is overriden below
MCHS_PKG_LICENSE_FILE="../COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20.7.24
MCHS_PKG_REVISION=2
# We use our source copies since old version snapshots are not kept on main site.
MCHS_PKG_SRCURL=https://github.com/mchs/distfiles/releases/download/2021.01.04/picolisp_${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=72e8d394ad32a6659210ac2cc4b7bb736dc9b94c6ac8d6296506b6dfdc92f90c
MCHS_PKG_DEPENDS="libcrypt, openssl"
MCHS_PKG_BUILD_IN_SRC=true
# arm and i686: The c code uses gcc-specific "variable length array in structure":
# x86_64: The assembly is not position-independent:
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# Validate that we have the right version:
	grep -q "Version ${MCHS_PKG_VERSION//./ }" src64/version.l || {
		mchs_error_exit "Picolisp version needs to be bumped"
	}

	if [ $MCHS_ARCH_BITS = 64 ]; then
		cd $MCHS_PKG_SRCDIR
		if [ $MCHS_ARCH = "aarch64" ]; then
			export MCHS_PKG_EXTRA_MAKE_ARGS=arm64.android
		else
			mchs_error_exit "Unsupported arch: $MCHS_ARCH"
		fi
		MCHS_PKG_SRCDIR=$MCHS_PKG_SRCDIR/src64
	else
		MCHS_PKG_SRCDIR=$MCHS_PKG_SRCDIR/src
	fi
	MCHS_PKG_BUILDDIR=$MCHS_PKG_SRCDIR
	ORIG_CFLAGS="$CFLAGS"
	CFLAGS+=" -c $LDFLAGS $CPPFLAGS"
}

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR/

	if [ $MCHS_ARCH_BITS = "64" ]; then
		$MCHS_HOST_PLATFORM-as -o ${MCHS_PKG_EXTRA_MAKE_ARGS}.base.o ${MCHS_PKG_EXTRA_MAKE_ARGS}.base.s
		$MCHS_HOST_PLATFORM-as -o ${MCHS_PKG_EXTRA_MAKE_ARGS}.ext.o ${MCHS_PKG_EXTRA_MAKE_ARGS}.ext.s
		$MCHS_HOST_PLATFORM-as -o ${MCHS_PKG_EXTRA_MAKE_ARGS}.ht.o ${MCHS_PKG_EXTRA_MAKE_ARGS}.ht.s

		# Use -fuse-ld=bfd to avoid using the gold linker (which McHs
		# patches NDK to use by default) as it causes (tzo), the time
		# zone offset, to always be 0 (and probably other problems):
		$CC -o ../bin/picolisp ${MCHS_PKG_EXTRA_MAKE_ARGS}.base.o \
			-Wl,--no-as-needed -rdynamic -lc -lm -ldl -pie -fuse-ld=bfd
		chmod +x ../bin/picolisp
		$CC -o ../lib/ext -shared -rdynamic -fuse-ld=bfd ${MCHS_PKG_EXTRA_MAKE_ARGS}.ext.o
		$CC -o ../lib/ht -shared -rdynamic -fuse-ld=bfd ${MCHS_PKG_EXTRA_MAKE_ARGS}.ht.o
	fi

	mkdir -p $MCHS_PREFIX/share/man/man1
	cp $MCHS_PKG_SRCDIR/../man/man1/{pil,picolisp}.1 $MCHS_PREFIX/share/man/man1/

	rm -Rf $MCHS_PREFIX/lib/picolisp
	mkdir -p $MCHS_PREFIX/lib/picolisp

	cp -Rf $MCHS_PKG_SRCDIR/../* $MCHS_PREFIX/lib/picolisp/
	rm -Rf $MCHS_PREFIX/lib/picolisp/{src,man,java,ersatz}

	# Replace first line "#!/usr/bin/picolisp /usr/lib/picolisp/lib.l":
	sed -i "1 s|^.*$|#!$MCHS_PREFIX/bin/picolisp $MCHS_PREFIX/lib/picolisp/lib.l|g" $MCHS_PREFIX/lib/picolisp/bin/pil

	( cd $MCHS_PREFIX/bin && ln -f -s ../lib/picolisp/bin/picolisp picolisp && ln -f -s ../lib/picolisp/bin/pil pil )

	# Bundled tools:
	$CC $ORIG_CFLAGS $CPPFLAGS $LDFLAGS -o $MCHS_PREFIX/lib/picolisp/bin/ssl ../src/ssl.c -lssl -lcrypto
	$CC $ORIG_CFLAGS $CPPFLAGS $LDFLAGS -o $MCHS_PREFIX/lib/picolisp/bin/httpGate ../src/httpGate.c -lssl -lcrypto

	# Man pages:
	cp $MCHS_PKG_SRCDIR/../man/man1/{pil,picolisp}.1 $MCHS_PREFIX/share/man/man1/
}
