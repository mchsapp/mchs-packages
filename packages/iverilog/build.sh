MCHS_PKG_HOMEPAGE=http://iverilog.icarus.com/
MCHS_PKG_DESCRIPTION="Icarus Verilog compiler and simulation tool"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=11.0
MCHS_PKG_SRCURL=https://github.com/steveicarus/iverilog/archive/v${MCHS_PKG_VERSION/./_}.tar.gz
MCHS_PKG_SHA256=6327fb900e66b46803d928b7ca439409a0dc32731d82143b20387be0833f1c95
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+.\d+"
MCHS_PKG_DEPENDS="libbz2, libc++, readline, zlib"
MCHS_PKG_BREAKS="iverilog-dev"
MCHS_PKG_REPLACES="iverilog-dev"

mchs_step_pre_configure() {
	LDFLAGS+=" -lm"
	aclocal
	autoconf
	export CFLAGS+=" -fcommon"

	local _BUILD_LIB=$MCHS_PKG_BUILDDIR/_build/lib
	mkdir -p $_BUILD_LIB
	for l in bz2 termcap; do
		echo '!<arch>' > $_BUILD_LIB/lib${l}.a
	done
	export LDFLAGS_FOR_BUILD+=" -L$_BUILD_LIB"
}

mchs_step_post_configure() {
	find . -name Makefile | xargs -n 1 sed -i \
		-e 's:@EXTRALIBS@::g' \
		-e 's:@MINGW32@:no:g' \
		-e 's:@PICFLAG@:-fPIC:g' \
		-e 's:@install_suffix@::g' \
		-e 's:@rdynamic@:-rdynamic:g' \
		-e 's:@shared@:-shared:g'
}
