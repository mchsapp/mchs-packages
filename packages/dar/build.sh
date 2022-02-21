MCHS_PKG_HOMEPAGE=http://dar.linux.free.fr/
MCHS_PKG_DESCRIPTION="A full featured command-line backup tool, short for Disk ARchive"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.7.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/dar/dar/${MCHS_PKG_VERSION}/dar-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=973fa977c19b32b1f9ecb62153c810ba8696f644eca048f214c77ad0e8eca255
MCHS_PKG_DEPENDS="attr, libbz2, libgcrypt, liblzma, liblzo, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH_BITS" = "32" ]; then
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mode=32"
	else
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mode=64"
	fi
	CXXFLAGS+=" $CPPFLAGS"
}
