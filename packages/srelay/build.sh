MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/socks-relay
MCHS_PKG_DESCRIPTION="A Free SOCKS proxy server"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.8p3
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/sourceforge/socks-relay/srelay-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=efa38cb3e9e745a05ccb4b59fcf5d041184f15dbea8eb80c1b0ce809bb00c924
MCHS_PKG_DEPENDS="libcrypt"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_CONFFILES="
etc/srelay.conf
etc/srelay.passwd
"

mchs_step_pre_configure() {
	export CPPFLAGS="${CPPFLAGS} -DLINUX"
}

mchs_step_make_install() {
	install -Dm755 srelay "${MCHS_PREFIX}/bin/srelay"
	install -Dm644 srelay.conf "${MCHS_PREFIX}/etc/srelay.conf"
	install -Dm644 srelay.passwd "${MCHS_PREFIX}/etc/srelay.passwd"
	install -Dm644 srelay.8 "${MCHS_PREFIX}/share/man/man8/srelay.8"
}

mchs_step_install_license() {
	install -Dm600 -t "$MCHS_PREFIX/share/doc/srelay" \
		"$MCHS_PKG_BUILDER_DIR"/LICENSE.txt
}
