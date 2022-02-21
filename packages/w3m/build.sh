MCHS_PKG_HOMEPAGE=http://w3m.sourceforge.net/
MCHS_PKG_DESCRIPTION="Text based Web browser and pager"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
_MAJOR_VERSION=0.5.3
_MINOR_VERSION=20190105
MCHS_PKG_VERSION=${_MAJOR_VERSION}.${_MINOR_VERSION}
MCHS_PKG_REVISION=6
# The upstream w3m project is dead, but every linux distribution uses
# this maintained fork in debian:
MCHS_PKG_SRCURL=https://github.com/tats/w3m/archive/v${_MAJOR_VERSION}+git${_MINOR_VERSION}.tar.gz
MCHS_PKG_SHA256=0467bb5429b75749205a3f57b9f5e8abba49929272aeab6fce94ff17953f0784
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="libgc, ncurses, openssl, zlib"
MCHS_PKG_SUGGESTS="perl"

# ac_cv_func_bcopy=yes to avoid w3m defining it's own bcopy function, which
# breaks 64-bit builds where NDK headers define bcopy as a macro:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes ac_cv_func_bcopy=yes"

#Overwrite the default /usr/bin/firefox with mchs-open-url as default external browser. That way, pressing "M" on a URL will open a link in Androids default Browser.
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --with-browser=mchs-open-url"
#Overwrite the default editor to just vi, as the default was /usr/bin/vi.
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --with-editor=nano"
# Build w3mimg with X11/imlib2.
# w3mimgdisplay is in w3m-img subpackage.
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-image=x11 --with-imagelib=imlib2"

# For Makefile.in.patch:
export MCHS_PKG_BUILDER_DIR
