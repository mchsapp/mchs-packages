MCHS_PKG_HOMEPAGE=https://github.com/MrJoy/ssss
MCHS_PKG_DESCRIPTION="Simple command-line implementation of Shamir's Secret Sharing Scheme"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.7
MCHS_PKG_SRCURL=https://github.com/MrJoy/ssss/archive/releases/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=dbb1f03797cb3fa69594530f9b2c36010f66705b9d5fbbc27293dce72b9c9473
MCHS_PKG_DEPENDS="libgmp"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	install -Dm700 ssss-split "$MCHS_PREFIX"/bin/
	ln -sfr "$MCHS_PREFIX"/bin/ssss-split $MCHS_PREFIX/bin/ssss-combine

	install -Dm600 ssss.1 "$MCHS_PREFIX"/share/man/man1/ssss.1
	ln -sfr \
		"$MCHS_PREFIX"/share/man/man1/ssss.1 \
		"$MCHS_PREFIX"/share/man/man1/ssss-combine.1
	ln -sfr \
		"$MCHS_PREFIX"/share/man/man1/ssss.1 \
		"$MCHS_PREFIX"/share/man/man1/ssss-split.1
}
