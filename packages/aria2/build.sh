MCHS_PKG_HOMEPAGE=https://aria2.github.io
MCHS_PKG_DESCRIPTION="Download utility supporting HTTP/HTTPS, FTP, BitTorrent and Metalink"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.36.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/aria2/aria2/releases/download/release-${MCHS_PKG_VERSION}/aria2-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=58d1e7608c12404f0229a3d9a4953d0d00c18040504498b483305bcb3de907a5
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_DEPENDS="libc++, c-ares, openssl, libxml2, zlib"
# sqlite3 is only used for loading cookies from firefox or chrome:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-openssl
--without-gnutls
--without-libuv
--without-sqlite3
--without-libssh2
ac_cv_func_basename=yes
ac_cv_func_getaddrinfo=yes
ac_cv_func_gettimeofday=yes
ac_cv_func_sleep=yes
ac_cv_func_usleep=yes
ac_cv_search_getaddrinfo=no
"

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH" = "arm" ]; then
		CXXFLAGS="${CFLAGS/-Oz/-Os}"
	fi
}
