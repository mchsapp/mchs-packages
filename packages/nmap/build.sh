MCHS_PKG_HOMEPAGE=https://nmap.org/
MCHS_PKG_DESCRIPTION="Utility for network discovery and security auditing"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=7.92
MCHS_PKG_SRCURL=https://nmap.org/dist/nmap-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=a5479f2f8a6b0b2516767d2f7189c386c1dc858d997167d7ec5cfc798c7571a1
MCHS_PKG_DEPENDS="libc++, libpcap, pcre, openssl, resolv-conf, liblua53, libssh2, zlib"
MCHS_PKG_RECOMMENDS="nmap-ncat"
# --without-nmap-update to avoid linking against libsvn_client:
# --without-zenmap to avoid python scripts for graphical gtk frontend:
# --without-ndiff to avoid python2-using ndiff utility:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_STRIP=llvm-strip --enable-static --with-liblua=$MCHS_PREFIX --without-nmap-update --without-zenmap --without-ndiff"
MCHS_PKG_BUILD_IN_SRC=true
