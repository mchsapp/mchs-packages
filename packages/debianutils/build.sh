MCHS_PKG_HOMEPAGE=https://packages.debian.org/debianutils
MCHS_PKG_DESCRIPTION="Small utilities which are used primarily by the installation scripts of Debian packages"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.7
MCHS_PKG_SRCURL=https://ftp.debian.org/debian/pool/main/d/debianutils/debianutils_${MCHS_PKG_VERSION}.orig.tar.gz
MCHS_PKG_SHA256=27ec9e0e7e44dc8ab611aa576330471bacb07e4491ffecf0d3aa6909c92f9022

MCHS_PKG_RM_AFTER_INSTALL="
bin/add-shell
bin/installkernel
bin/remove-shell
bin/update-shells
share/man/man8/add-shell.8
share/man/man8/installkernel.8
share/man/man8/remove-shell.8
share/man/man8/update-shells.8
"
