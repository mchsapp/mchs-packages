MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/libtasn1/
MCHS_PKG_DESCRIPTION="This is GNU Libtasn1, a small ASN.1 library"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.17.0
MCHS_PKG_SRCURL=https://gitlab.com/gnutls/libtasn1.git

mchs_step_post_get_source() {
	./bootstrap
}
