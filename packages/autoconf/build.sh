MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/autoconf/autoconf.html
MCHS_PKG_DESCRIPTION="Creator of shell scripts to configure source code packages"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.71
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/autoconf/autoconf-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=f14c83cfebcc9427f2c3cea7258bd90df972d92eb26752da4ddad81c87a0faa4
MCHS_PKG_DEPENDS="m4, make, perl"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_GROUPS="base-devel"

mchs_step_post_get_source() {
	perl -p -i -e "s|/bin/sh|$MCHS_PREFIX/bin/sh|" lib/*/*.m4
}

mchs_step_post_massage() {
	perl -p -i -e "s|/usr/bin/m4|$MCHS_PREFIX/bin/m4|" bin/*
	perl -p -i -e "s|CONFIG_SHELL-/bin/sh|CONFIG_SHELL-$MCHS_PREFIX/bin/sh|" bin/autoconf
}
