MCHS_PKG_HOMEPAGE=https://keep.imfreedom.org/libgnt/libgnt
MCHS_PKG_DESCRIPTION="An ncurses toolkit for creating text-mode graphical user interfaces in a fast and easy way"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.14.3
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/pidgin/libgnt/${MCHS_PKG_VERSION}/libgnt-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=57f5457f72999d0bb1a139a37f2746ec1b5a02c094f2710a339d8bcea4236123
MCHS_PKG_DEPENDS="glib, libxml2, ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Ddoc=false -Dpython2=false"
