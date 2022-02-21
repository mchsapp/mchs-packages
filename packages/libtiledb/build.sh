MCHS_PKG_HOMEPAGE=https://tiledb.com/
MCHS_PKG_DESCRIPTION="A powerful engine for storing and accessing dense and sparse multi-dimensional arrays"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.6.2
MCHS_PKG_SRCURL=https://github.com/TileDB-Inc/TileDB/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6974dd4e53edabda75cc8fa6b5772c71d6adb3eaafa76397e0542b3606f6f783
MCHS_PKG_DEPENDS="ca-certificates, libbz2, libc++, liblz4, libspdlog, openssl, zlib, zstd"
MCHS_PKG_BUILD_DEPENDS="clipp, fmt"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DTILEDB_SUPERBUILD=OFF
-DTILEDB_WERROR=OFF
-DTILEDB_STATS=OFF
-DTILEDB_TESTS=OFF
-DHAVE_AVX2_EXITCODE=1
-DHAVE_AVX2_EXITCODE__TRYRUN_OUTPUT=
"
