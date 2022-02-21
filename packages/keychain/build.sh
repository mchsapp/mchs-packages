MCHS_PKG_HOMEPAGE=https://www.funtoo.org/Keychain
MCHS_PKG_DESCRIPTION="keychain ssh-agent front-end"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.8.5
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/funtoo/keychain/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=dcce703e5001211c8ebc0528f45b523f84d2bceeb240600795b4d80cb8475a0b
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="dash, gnupg"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	sed -iE "s@^PATH=.*@PATH=$MCHS_PREFIX/bin@" keychain
	install -Dm700 keychain "${MCHS_PREFIX}"/bin/keychain
	install -Dm600 keychain.1 "${MCHS_PREFIX}"/share/man/man1/keychain.1
}
