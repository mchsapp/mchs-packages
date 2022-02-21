MCHS_PKG_HOMEPAGE=http://point-at-infinity.org/seccure/
MCHS_PKG_DESCRIPTION="SECCURE Elliptic Curve Crypto Utility for Reliable Encryption"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=http://point-at-infinity.org/seccure/seccure-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6566ce4afea095f83690b93078b910ca5b57b581ebc60e722f6e3fe8e098965b
MCHS_PKG_DEPENDS="libgcrypt"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	make seccure-key
}

mchs_step_make_install() {
	install -Dm700 seccure-key "$MCHS_PREFIX"/bin/
	install -Dm600 seccure.1 "$MCHS_PREFIX"/share/man/man1/

	for i in encrypt decrypt sign verify signcrypt veridec dh; do
		ln -sfr "$MCHS_PREFIX"/bin/seccure-key "$MCHS_PREFIX"/bin/seccure-${i}
		ln -sfr "$MCHS_PREFIX"/share/man/man1/seccure.1 "$MCHS_PREFIX"/share/man/man1/seccure-${i}.1
	done
	unset i
}
