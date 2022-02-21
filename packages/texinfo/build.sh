MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/texinfo/
MCHS_PKG_DESCRIPTION="Documentation system for on-line information and printed output"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.8
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/texinfo/texinfo-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=8eb753ed28bca21f8f56c1a180362aed789229bd62fff58bf8368e9beb59fec4
# gawk is used by texindex:
MCHS_PKG_DEPENDS="libiconv, ncurses, perl, gawk"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-perl-xs"
MCHS_PKG_GROUPS="base-devel"
