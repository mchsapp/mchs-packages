MCHS_PKG_HOMEPAGE=https://zeromq.org/
MCHS_PKG_DESCRIPTION="Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ."
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.3.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/zeromq/libzmq/releases/download/v${MCHS_PKG_VERSION}/zeromq-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c593001a89f5a85dd2ddf564805deb860e02471171b3f204944857336295c3e5
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, libsodium"
MCHS_PKG_BREAKS="libzmq-dev"
MCHS_PKG_REPLACES="libzmq-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-libsodium --disable-libunwind --disable-Werror"

mchs_step_post_get_source() {
	./autogen.sh
}
