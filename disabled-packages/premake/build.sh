MCHS_PKG_HOMEPAGE=http://premake.github.io/
MCHS_PKG_DESCRIPTION="Build script generator"
MCHS_PKG_VERSION=4.4-beta5
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/premake/Premake/4.4/premake-${MCHS_PKG_VERSION}-src.zip
# MCHS_PKG_DEPENDS="pcre, openssl, libuuid"
# MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-ssl=openssl"


mchs_step_pre_configure() {
	MCHS_PKG_BUILDDIR=$MCHS_PKG_SRCDIR/build/gmake.unix
}
