MCHS_PKG_HOMEPAGE=http://joeyh.name/code/moreutils/
MCHS_PKG_DESCRIPTION="A growing collection of the unix tools that nobody thought to write thirty years ago"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.65
MCHS_PKG_SRCURL=http://ftp.debian.org/debian/pool/main/m/moreutils/moreutils_$MCHS_PKG_VERSION.orig.tar.xz
MCHS_PKG_SHA256=ba0cfaa1ff6ead2b15c62a67292de66a366f9b815a09697b54677f7e15f5a2b2
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_BUILD_IN_SRC=true

# chronic requires set of external perl modules.
MCHS_PKG_RM_AFTER_INSTALL="
bin/chronic
share/man/man1/chronic.1
share/man/man1/parallel.1
"
