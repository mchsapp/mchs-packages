MCHS_PKG_HOMEPAGE=http://bvi.sourceforge.net/
MCHS_PKG_DESCRIPTION="Binary file editor based on vi"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_VERSION=1.4.1
MCHS_PKG_SRCURL=http://sourceforge.net/projects/bvi/files/bvi/${MCHS_PKG_VERSION}/bvi-${MCHS_PKG_VERSION}.src.tar.gz
MCHS_PKG_SHA256=3035255ca79e0464567d255baa5544f7794e2b7eb791dcc60cc339cf1aa01e28
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_ncursesw6_addnwstr=yes"
MCHS_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"
