MCHS_PKG_HOMEPAGE=https://ccache.samba.org
MCHS_PKG_DESCRIPTION="Compiler cache for fast recompilation of C/C++ code"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.5.1
MCHS_PKG_SRCURL=https://github.com/ccache/ccache/releases/download/v$MCHS_PKG_VERSION/ccache-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=51186ebe0326365f4e6131e1caa8911de7da4aa6718efc00680322d63a759517
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="zlib, zstd"

#[46/89] Building ASM object src/third_party/blake3/CMakeFiles/blake3.dir/blake3_sse2_x86-64_unix.S.o
#FAILED: src/third_party/blake3/CMakeFiles/blake3.dir/blake3_sse2_x86-64_unix.S.o
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DHAVE_ASM_AVX2=FALSE
-DHAVE_ASM_AVX512=FALSE
-DHAVE_ASM_SSE2=FALSE
-DHAVE_ASM_SSE41=FALSE
-DREDIS_STORAGE_BACKEND=OFF
"
