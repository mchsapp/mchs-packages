MCHS_PKG_HOMEPAGE=https://www.nongnu.org/cvs/
MCHS_PKG_DESCRIPTION="Concurrent Versions System"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION="1:1.12.13"
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL="https://github.com/mchs/distfiles/releases/download/2021.01.04/cvs-${MCHS_PKG_VERSION:2}+real-26.tar.xz"
MCHS_PKG_SHA256=0eda91f5e8091b676c90b2a171f24f9293acb552f4e4f77b590ae8d92a547256
MCHS_PKG_DEPENDS="zlib, libandroid-support"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
cvs_cv_func_printf_ptr=yes
ac_cv_header_syslog_h=no
--disable-server
--with-external-zlib
"
MCHS_PKG_RM_AFTER_INSTALL="bin/cvsbug share/man/man8/cvsbug.8"
