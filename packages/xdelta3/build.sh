MCHS_PKG_HOMEPAGE=https://github.com/jmacd/xdelta
MCHS_PKG_DESCRIPTION='xdelta3 - VCDIFF (RFC 3284) binary diff tool'
MCHS_PKG_LICENSE=Apache-2.0
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1.0
MCHS_PKG_SRCURL=https://github.com/jmacd/xdelta/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=7515cf5378fca287a57f4e2fee1094aabc79569cfe60d91e06021a8fd7bae29d
MCHS_PKG_DEPENDS=liblzma

mchs_step_post_get_source() {
	MCHS_PKG_SRCDIR+=/xdelta3
}

mchs_step_pre_configure() {
	autoreconf --install
}
