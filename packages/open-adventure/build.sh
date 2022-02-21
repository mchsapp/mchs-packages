MCHS_PKG_HOMEPAGE=http://www.catb.org/~esr/open-adventure/
MCHS_PKG_DESCRIPTION="Forward-port of the original Colossal Cave Adventure from 1976-77"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=1.9
MCHS_PKG_REVISION=1
MCHS_PKG_SHA256=13a8bf9556014021b0e1f144f23e00afc05e92e4952b2ee7ad1dab0c079a6694
MCHS_PKG_SRCURL=https://gitlab.com/esr/open-adventure/-/archive/${MCHS_PKG_VERSION}/open-adventure-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_DEPENDS="libedit"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

mchs_step_make_install () {
	install -m 0755 advent $MCHS_PREFIX/bin
}
