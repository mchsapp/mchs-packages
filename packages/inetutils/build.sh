MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/inetutils/
MCHS_PKG_DESCRIPTION="Collection of common network programs"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.9.4
MCHS_PKG_REVISION=12
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/inetutils/inetutils-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=849d96f136effdef69548a940e3e0ec0624fc0c81265296987986a0dd36ded37
MCHS_PKG_DEPENDS="readline"
# These are old cruft / not suited for android
# (we --disable-traceroute as it requires root
# in favour of tracepath, which sets up traceroute
# as a symlink to tracepath):
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ifconfig
--disable-ping
--disable-ping6
--disable-rcp
--disable-rexec
--disable-rexecd
--disable-rlogin
--disable-rsh
--disable-traceroute
--disable-uucpd
ac_cv_lib_crypt_crypt=no
"

mchs_step_pre_configure() {
	CPPFLAGS+=" -DLOGIN_PROCESS=6 -DDEAD_PROCESS=8 -DLOG_NFACILITIES=24 -fcommon"
	touch -d "next hour" ./man/whois.1
}
