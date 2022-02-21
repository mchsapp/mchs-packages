MCHS_PKG_HOMEPAGE=https://www.nlnetlabs.nl/projects/ldns/
MCHS_PKG_DESCRIPTION="Library for simplifying DNS programming and supporting recent and experimental RFCs"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.1
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://www.nlnetlabs.nl/downloads/ldns/ldns-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8ac84c16bdca60e710eea75782356f3ac3b55680d40e1530d7cea474ac208229
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BREAKS="ldns-dev"
MCHS_PKG_REPLACES="ldns-dev"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-ssl=$MCHS_PREFIX
--disable-gost
--with-drill
"

mchs_step_post_make_install() {
	# The ldns build doesn't install its pkg-config:
	mkdir -p $MCHS_PREFIX/lib/pkgconfig
	cp packaging/libldns.pc $MCHS_PREFIX/lib/pkgconfig/libldns.pc
}
