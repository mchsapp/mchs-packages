MCHS_PKG_HOMEPAGE=https://zeromq.org/
MCHS_PKG_DESCRIPTION="High-level C binding for ZeroMQ"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.2.1
MCHS_PKG_SRCURL=https://github.com/zeromq/czmq/releases/download/v${MCHS_PKG_VERSION}/czmq-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=5d720a204c2a58645d6f7643af15d563a712dad98c9d32c1ed913377daa6ac39
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libzmq, libsodium, liblz4, libuuid"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-drafts=no"

mchs_step_pre_configure() {
	CFLAGS+=" -DCZMQ_HAVE_ANDROID=1"
	LDFLAGS+=" -llog"
	autoconf
}
