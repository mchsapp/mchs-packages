MCHS_PKG_HOMEPAGE=http://x3270.bgp.nu/
MCHS_PKG_DESCRIPTION="A family of IBM 3270 terminal emulators and related tools"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="include/copyright.h"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.1ga11
MCHS_PKG_SRCURL=https://prdownloads.sourceforge.net/x3270/suite3270-${MCHS_PKG_VERSION}-src.tgz
MCHS_PKG_SHA256=c36d12fcf211cce48c7488b06d806b0194c71331abdce6da90953099acb1b0bf
MCHS_PKG_DEPENDS="less, libexpat, libiconv, ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-windows
--disable-x3270
--disable-tcl3270 
ac_cv_path_LESSPATH=$MCHS_PREFIX/bin/less
"

mchs_step_pre_configure() {
	CPPFLAGS+=" -DNCURSES_WIDECHAR"

	find $MCHS_PKG_SRCDIR -name '*.c' | xargs -n 1 sed -i \
		-e 's:"\(/bin/sh"\):"'$MCHS_PREFIX'\1:g' \
		-e 's:"\(/tmp\):"'$MCHS_PREFIX'\1:g'
}

mchs_step_post_configure() {
	local bin=$MCHS_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	pushd $MCHS_PKG_SRCDIR/Common
	$CC_FOR_BUILD mkicon.c -o mkicon
	cp mkicon $bin/
	pushd c3270
	$CC_FOR_BUILD mkkeypad.c -o mkkeypad
	cp mkkeypad $bin/
	popd
	popd
	PATH=$bin:$PATH
}
