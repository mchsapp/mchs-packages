MCHS_PKG_HOMEPAGE=https://eternalterminal.dev
MCHS_PKG_DESCRIPTION="A remote shell that automatically reconnects without interrupting the session"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_VERSION=6.1.11
MCHS_PKG_SRCURL=https://github.com/MisterTea/EternalTerminal/archive/et-v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bff58ae9122a39a7012e741d2d514b0966725c942021f3279fa7e2b00cfd20a3
MCHS_PKG_DEPENDS="libc++, protobuf, libsodium, openssl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DDISABLE_VCPKG=1"

mchs_step_pre_configure() {
	mchs_setup_protobuf
}

mchs_step_post_make_install() {
	install -Dm600 $MCHS_PKG_SRCDIR/etc/et.cfg $MCHS_PREFIX/etc/
}
