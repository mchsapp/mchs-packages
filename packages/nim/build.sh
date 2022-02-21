MCHS_PKG_HOMEPAGE=https://nim-lang.org/
MCHS_PKG_DESCRIPTION="Nim programming language compiler"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="copying.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.0
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://nim-lang.org/download/nim-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=52065d48d72a72702ec1afe5f7a9831e11673531e279cdff9caec01a07eec63d
MCHS_PKG_DEPENDS="clang, git, libandroid-glob"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_BUILD_IN_SRC=true

_NIM_TOOLS="
koch
dist/nimble/src/nimble
nimpretty/nimpretty
nimsuggest/nimsuggest
testament/testament
tools/nimgrep
"

mchs_step_host_build() {
	cp -r ../src/* ./
	make -j $MCHS_MAKE_PROCESSES CC=gcc LD=gcc
}

mchs_step_make() {
	if [ $MCHS_ARCH = "x86_64" ]; then
		export	NIM_ARCH=amd64
	elif [ $MCHS_ARCH = "i686" ]; then
		export	NIM_ARCH=i386
	elif [ $MCHS_ARCH = "aarch64" ]; then
		export NIM_ARCH=arm64
	else
		export NIM_ARCH=arm
	fi
	LDFLAGS+=" -landroid-glob"
	sed -i "s%\@CC\@%${CC}%g"  config/nim.cfg
	sed -i "s%\@CFLAGS\@%${CFLAGS}%g" config/nim.cfg
	sed -i "s%\@LDFLAGS\@%${LDFLAGS}%g" config/nim.cfg
	sed -i "s%\@CPPFLAGS\@%${CPPFLAGS}%g" config/nim.cfg

	find -name "stdlib_osproc.nim.c" | xargs -n 1 sed -i 's',"/system/bin/sh\"\,\ 14","${MCHS_PREFIX}/bin/sh\"\,\ 38",'g'
	PATH=$MCHS_PKG_HOSTBUILD_DIR/bin:$PATH

	if [ $NIM_ARCH = "amd64" ]; then
		sed -i 's/arm64/amd64/g' makefile
	fi
	export CFLAGS=" $CPPFLAGS $CFLAGS  -w  -fno-strict-aliasing"
	make LD=$CC uos=linux mycpu=$NIM_ARCH myos=android  -j $MCHS_MAKE_PROCESSES useShPath=$MCHS_PREFIX/bin/sh
	cp config/nim.cfg ../host-build/config

	for cmd in $_NIM_TOOLS; do
		pushd $(dirname $cmd)
		case $cmd in
			koch) nim_flags="--opt:size" ;;
			*) nim_flags= ;;
		esac
		nim --cc:clang --clang.exe=$CC --clang.linkerexe=$CC $nim_flags --define:mchs -d:release --os:android --cpu:$NIM_ARCH  -t:"$CPPFLAGS $CFLAGS" -l:"$LDFLAGS -landroid-glob" -d:tempDir:$MCHS_PREFIX/tmp c $(basename $cmd).nim
		popd
	done
}

mchs_step_make_install() {
	./install.sh $MCHS_PREFIX/lib
	ln -sfr $MCHS_PREFIX/lib/nim/bin/nim $MCHS_PREFIX/bin/
	for cmd in $_NIM_TOOLS; do
		cp $cmd $MCHS_PREFIX/lib/nim/bin/
		ln -sfr $MCHS_PREFIX/lib/nim/bin/$(basename $cmd) $MCHS_PREFIX/bin/
	done
	mkdir -p $MCHS_PREFIX/lib/nim/tools
	cp -r tools/dochack $MCHS_PREFIX/lib/nim/tools/
}
