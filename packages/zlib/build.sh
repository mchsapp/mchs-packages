MCHS_PKG_HOMEPAGE=https://www.zlib.net/
MCHS_PKG_DESCRIPTION="Compression library implementing the deflate compression method found in gzip and PKZIP"
MCHS_PKG_LICENSE="ZLIB"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.11
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://www.zlib.net/zlib-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=4ff941449631ace0d4d203e3483be9dbc9da454084111f97ea0a2114e19bf066
MCHS_PKG_BREAKS="ndk-sysroot (<< 19b-3), zlib-dev"
MCHS_PKG_REPLACES="ndk-sysroot (<< 19b-3), zlib-dev"

mchs_step_configure() {
	"$MCHS_PKG_SRCDIR/configure" --prefix=$MCHS_PREFIX
	sed -n '/Copyright (C) 1995-/,/madler@alumni.caltech.edu/p' "$MCHS_PKG_SRCDIR/zlib.h" > "$MCHS_PKG_SRCDIR/LICENSE"
}
