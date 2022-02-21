MCHS_PKG_HOMEPAGE=https://codeberg.org/Anoxinon_e.V./xmppc
MCHS_PKG_DESCRIPTION="Command Line Interface Tool for XMPP"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="j.r <j.r@jugendhacker.de>"
MCHS_PKG_VERSION=0.1.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://codeberg.org/Anoxinon_e.V./xmppc/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=98d68deb57924e5ed06613d8b275fb0bf98aab822fb590fe8d9894410a8544ee
MCHS_PKG_DEPENDS="libstrophe, glib, gpgme"

mchs_step_pre_configure() {
	./bootstrap.sh
}
