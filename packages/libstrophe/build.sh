MCHS_PKG_HOMEPAGE=https://strophe.im/libstrophe
MCHS_PKG_DESCRIPTION="libstrophe is a minimal XMPP library written in C."
MCHS_PKG_LICENSE="MIT, GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.11.0
MCHS_PKG_SRCURL=https://github.com/strophe/libstrophe/releases/download/${MCHS_PKG_VERSION}/libstrophe-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3605a20f32d7b3193292e238b410d595e01b1d64510f42c108da13c09b60688a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="openssl, libexpat, c-ares"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-cares"

mchs_step_pre_configure() {
	./bootstrap.sh
}
