MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/recutils/
MCHS_PKG_DESCRIPTION="Set of tools and libraries to access human-editable, plain text databases called recfiles"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Rowan Wookey <admin@rwky.net>"
MCHS_PKG_VERSION=1.8
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/recutils/recutils-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=df8eae69593fdba53e264cbf4b2307dfb82120c09b6fab23e2dad51a89a5b193
# Prevent libandroid-spawn from being picked up
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_spawn_h=no"
MCHS_PKG_EXTRA_MAKE_ARGS="lispdir=${MCHS_PREFIX}/share/emacs/site-lisp"
