MCHS_PKG_HOMEPAGE=https://rsync.samba.org/
MCHS_PKG_DESCRIPTION="Utility that provides fast incremental file transfer"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.2.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://rsync.samba.org/ftp/rsync/src/rsync-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=becc3c504ceea499f4167a260040ccf4d9f2ef9499ad5683c179a697146ce50e
MCHS_PKG_DEPENDS="libiconv, liblz4, libpopt, openssh | dropbear, openssl-tool, zlib, zstd"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-rsyncd-conf=$MCHS_PREFIX/etc/rsyncd.conf
--with-included-popt=no
--with-included-zlib=no
--disable-debug
--disable-simd
--disable-xattr-support
--disable-xxhash
"
