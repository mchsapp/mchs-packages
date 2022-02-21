MCHS_PKG_HOMEPAGE="https://www.cups.org/"
MCHS_PKG_DESCRIPTION="Common UNIX Printing System"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION="2.3.3"
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL="https://github.com/apple/cups/releases/download/v${MCHS_PKG_VERSION}/cups-${MCHS_PKG_VERSION}-source.tar.gz"
MCHS_PKG_SHA256="261fd948bce8647b6d5cb2a1784f0c24cc52b5c4e827b71d726020bcc502f3ee"
MCHS_PKG_DEPENDS="libiconv, libcrypt"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_CONFFILES="
etc/cups/cups-files.conf
etc/cups/cupsd.conf
etc/cups/snmp.conf
"

MCHS_PKG_SERVICE_SCRIPT=("cupsd" "mkdir -p $MCHS_PREFIX/var/run/cups && exec cupsd -f")

mchs_step_make() {
	make LIBS="-pthread $LDFLAGS -Wl,--hash-style=both -lm -lcrypt -liconv -lz" -j${MCHS_MAKE_PROCESSES}
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${MCHS_PREFIX}/bin/sh
	mkdir -p $MCHS_PREFIX/var/run/cups
	EOF
}
