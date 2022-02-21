MCHS_PKG_HOMEPAGE=https://theunarchiver.com/command-line
MCHS_PKG_DESCRIPTION="Command line tools for archive and file unarchiving and extraction"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=()
MCHS_PKG_REVISION=1
MCHS_PKG_VERSION+=(1.10.7)
MCHS_PKG_VERSION+=(1.1)
MCHS_PKG_SRCURL=(https://github.com/MacPaw/XADMaster/archive/v${MCHS_PKG_VERSION}/XADMaster-${MCHS_PKG_VERSION}.tar.gz
                   https://github.com/MacPaw/universal-detector/archive/${MCHS_PKG_VERSION[1]}/universal-detector-${MCHS_PKG_VERSION[1]}.tar.gz)
MCHS_PKG_SHA256=(3d766dc1856d04a8fb6de9942a6220d754d0fa7eae635d5287e7b1cf794c4f45
                   8e8532111d0163628eb828a60d67b53133afad3f710b1967e69d3b8eee28a811)
MCHS_PKG_DEPENDS="libbz2, libc++, libgnustep-base, libicu, libwavpack, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="-e -f Makefile.linux"

mchs_step_post_get_source() {
	mv universal-detector-${MCHS_PKG_VERSION[1]} UniversalDetector
	cp $MCHS_PKG_BUILDER_DIR/sys_time.c ./
}

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
	export OBJCC="$CC"
	export OBJCFLAGS="$CFLAGS -fobjc-nonfragile-abi"
	LD="$CXX"
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin lsar unar
	install -Dm600 -t $MCHS_PREFIX/share/man/man1 Extra/*.1
	mkdir -p $MCHS_PREFIX/share/bash-completion/completions
	for c in lsar unar; do
		install -Dm600 Extra/${c}.bash_completion \
			$MCHS_PREFIX/share/bash-completion/completions/${c}
	done
}
