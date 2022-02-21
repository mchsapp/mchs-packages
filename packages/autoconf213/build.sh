MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/autoconf/autoconf.html
MCHS_PKG_DESCRIPTION="Creator of shell scripts to configure source code packages (legacy v2.13)"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.13
MCHS_PKG_SRCURL=http://ftp.gnu.org/gnu/autoconf/autoconf-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f0611136bee505811e9ca11ca7ac188ef5323a8e2ef19cffd3edb3cf08fd791e
MCHS_PKG_DEPENDS="m4, make, perl"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--program-suffix=-2.13"

mchs_step_post_get_source() {
	perl -p -i -e "s|/bin/sh|$MCHS_PREFIX/bin/sh|" *.m4
}

mchs_step_post_massage() {
	perl -p -i -e "s|/usr/bin/m4|$MCHS_PREFIX/bin/m4|" $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/bin/*
	perl -p -i -e "s|CONFIG_SHELL-/bin/sh|CONFIG_SHELL-$MCHS_PREFIX/bin/sh|" $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/bin/autoconf-2.13
}
