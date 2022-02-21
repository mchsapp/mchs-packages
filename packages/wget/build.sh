MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/wget/
MCHS_PKG_DESCRIPTION="Commandline tool for retrieving files using HTTP, HTTPS and FTP"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.21.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/wget/wget-${MCHS_PKG_VERSION}.tar.lz
MCHS_PKG_SHA256=db9bbe5347e6faa06fc78805eeb808b268979455ead9003a608569c9d4fc90ad
MCHS_PKG_DEPENDS="libiconv, pcre2, openssl, libuuid, libandroid-support, libunistring, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_getpass=yes
ac_cv_header_spawn_h=no
--disable-iri
--with-ssl=openssl
"
