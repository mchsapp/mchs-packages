MCHS_PKG_HOMEPAGE=http://smarden.org/runit
MCHS_PKG_DESCRIPTION="Tools to provide service supervision and to manage services"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=2.1.2
MCHS_PKG_REVISION=3
_COMMIT=339dc067c537e36ecb1232f0cfed792ca36c59dd
MCHS_PKG_SRCURL=https://git.sr.ht/~grimler/runit/archive/$_COMMIT.tar.gz
MCHS_PKG_SHA256=f9f0010329dbdbe9021578f3dd54c11d0cab9489375265a172e1da20ffeb03cf
MCHS_PKG_RM_AFTER_INSTALL="
bin/runit
bin/runit-init
share/man/man8/runit.8
share/man/man8/runit-init.8
"

mchs_step_pre_configure() {
	autoreconf -vfi
}
