MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/groff/
MCHS_PKG_DESCRIPTION="typesetting system that reads plain text mixed with formatting commands and produces formatted output"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.22.4
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/groff/groff-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e78e7b4cb7dec310849004fa88847c44701e8d133b5d4c13057d876c1bad0293
MCHS_PKG_DEPENDS="libc++, perl, man"
MCHS_PKG_GROUPS="base-devel"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true

MCHS_PKG_RM_AFTER_INSTALL="
bin/soelim
share/man/man1/soelim.1*
share/man/man7/roff.7*
"

mchs_step_pre_configure() {
	sed -i "s|@abs_top_builddir@|${MCHS_TOPDIR}/groff/host-build|" Makefile.in
}

mchs_step_post_make_install() {
	install -Dm600 $MCHS_PKG_HOSTBUILD_DIR/font/devpdf/[A-CEG-Z]* \
		$MCHS_PREFIX/share/groff/current/font/devpdf/
}
