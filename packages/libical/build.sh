MCHS_PKG_HOMEPAGE=http://libical.github.io/libical/
MCHS_PKG_DESCRIPTION="Libical is an Open Source implementation of the iCalendar protocols and protocol data units"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.0.14
MCHS_PKG_SRCURL=https://github.com/libical/libical/releases/download/v$MCHS_PKG_VERSION/libical-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=4284b780356f1dc6a01f16083e7b836e63d3815e27ed0eaaad684712357ccc8f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, libicu, libxml2"
MCHS_PKG_BREAKS="libical-dev"
MCHS_PKG_REPLACES="libical-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS=" -DSHARED_ONLY=true -DICAL_GLIB=false -DUSE_BUILTIN_TZDATA=true -DPERL_EXECUTABLE=/usr/bin/perl"
