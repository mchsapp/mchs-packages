MCHS_PKG_HOMEPAGE=http://xmlstar.sourceforge.net/
MCHS_PKG_DESCRIPTION="Command line XML toolkit"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.1
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/xmlstar/xmlstarlet/${MCHS_PKG_VERSION}/xmlstarlet-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=15d838c4f3375332fd95554619179b69e4ec91418a3a5296e7c631b7ed19e7ca
MCHS_PKG_DEPENDS="libxslt, libxml2"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-libxml-include-prefix=${MCHS_PREFIX}/include/libxml2"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_make_install() {
	ln -sfr $MCHS_PREFIX/bin/xml $MCHS_PREFIX/bin/xmlstarlet
}
