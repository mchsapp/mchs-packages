MCHS_PKG_HOMEPAGE=http://gondor.apana.org.au/~herbert/dash/
MCHS_PKG_DESCRIPTION="Small POSIX-compliant implementation of /bin/sh"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.11.5
MCHS_PKG_SRCURL=http://gondor.apana.org.au/~herbert/dash/files/dash-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=db778110891f7937985f29bf23410fe1c5d669502760f584e54e0e7b29e123bd
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"

mchs_step_post_make_install() {
	# Symlink sh -> dash
	ln -sfr $MCHS_PREFIX/bin/{dash,sh}
	ln -sfr $MCHS_PREFIX/share/man/man1/{dash,sh}.1
}
