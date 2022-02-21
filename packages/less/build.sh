MCHS_PKG_HOMEPAGE=https://www.greenwoodsoftware.com/less/
MCHS_PKG_DESCRIPTION="Terminal pager program used to view the contents of a text file one screen at a time"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=590
MCHS_PKG_SRCURL=https://www.greenwoodsoftware.com/less/less-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6aadf54be8bf57d0e2999a3c5d67b1de63808bb90deb8f77b028eafae3a08e10
MCHS_PKG_DEPENDS="ncurses, pcre2"
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-regex=pcre2"
