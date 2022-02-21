MCHS_PKG_HOMEPAGE=https://github.com/protocolbuffers/protobuf
MCHS_PKG_DESCRIPTION="Protocol buffers C++ library"
MCHS_PKG_LICENSE="BSD 3-Clause"
# MCHS_PKG_SRCDIR is overriden below so we need to specify license file
MCHS_PKG_LICENSE_FILE="../LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2:3.19.3
MCHS_PKG_SRCURL=https://github.com/protocolbuffers/protobuf/archive/v${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=390191a0d7884b3e52bb812c440ad1497b9d484241f37bb8e2ccc8c2b72d6c36
MCHS_PKG_AUTO_UPDATE=false
MCHS_PKG_DEPENDS="libc++, zlib"
MCHS_PKG_BREAKS="libprotobuf-dev"
MCHS_PKG_REPLACES="libprotobuf-dev"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dprotobuf_BUILD_TESTS=OFF
-DBUILD_SHARED_LIBS=ON
"

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR+="/cmake/"
}
