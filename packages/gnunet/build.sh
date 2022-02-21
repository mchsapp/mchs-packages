MCHS_PKG_HOMEPAGE=https://gnunet.org
MCHS_PKG_DESCRIPTION="A framework for secure peer-to-peer networking"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_SRCURL=https://git.gnunet.org/git/gnunet.git
MCHS_PKG_VERSION=0.15.3
MCHS_PKG_DEPENDS="gnurl, libgcrypt, libgmp, libidn, libjansson, libltdl, libmicrohttpd, libsqlite, libunistring, libsodium"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_have_decl_struct_in6_ifreq=yes"

mchs_step_pre_configure() {
	CPPFLAGS+=" -D_LINUX_IN6_H"
	./bootstrap
}
