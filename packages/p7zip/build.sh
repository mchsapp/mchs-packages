MCHS_PKG_HOMEPAGE=https://github.com/jinfeihan57/p7zip
MCHS_PKG_DESCRIPTION="Command-line version of the 7zip compressed file archiver"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=17.04
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/jinfeihan57/p7zip/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ea029a2e21d2d6ad0a156f6679bd66836204aa78148a4c5e498fe682e77127ef
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, libiconv"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	export CXXFLAGS="$CXXFLAGS $CPPFLAGS -Wno-c++11-narrowing"
	export LDFLAGS="$LDFLAGS -liconv"
	cp makefile.android_arm makefile.machine
}

mchs_step_make() {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		make -j $MCHS_MAKE_PROCESSES 7z 7za OPTFLAGS="${CXXFLAGS}" DEST_HOME=$MCHS_PREFIX
}

mchs_step_make_install() {
	chmod +x install.sh
	make install DEST_HOME=$MCHS_PREFIX DEST_MAN=$MCHS_PREFIX/share/man
}
