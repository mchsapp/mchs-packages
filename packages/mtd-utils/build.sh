MCHS_PKG_HOMEPAGE=http://www.linux-mtd.infradead.org/
MCHS_PKG_DESCRIPTION="Utilities for dealing with MTD devices"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.3
MCHS_PKG_SRCURL=ftp://ftp.infradead.org/pub/mtd-utils/mtd-utils-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=11305a5daf6fc6ed85120695c8593290b577effb039adbfa63d35b4418ff5630
MCHS_PKG_DEPENDS="openssl, liblzo, libuuid, zlib, zstd"
MCHS_PKG_BUILD_IN_SRC=true
# only removed because it calls getrandom, which comes in API 28
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-ubifs"
