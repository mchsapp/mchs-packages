MCHS_PKG_HOMEPAGE=https://grpc.io/
MCHS_PKG_DESCRIPTION="High performance, open source, general RPC framework that puts mobile and HTTP/2 first"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_SRCURL=https://github.com/grpc/grpc.git
MCHS_PKG_VERSION=1.44.0
MCHS_PKG_DEPENDS="ca-certificates, libc++, libre2, openssl, protobuf, c-ares, zlib"
MCHS_PKG_BREAKS="libgrpc-dev"
MCHS_PKG_REPLACES="libgrpc-dev"
MCHS_PKG_BUILD_DEPENDS="gflags, gflags-static, libprotobuf"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_STRIP=$(command -v strip)
-DGIT_EXECUTABLE=$(command -v git)
-DBUILD_SHARED_LIBS=ON
-DgRPC_CARES_PROVIDER=package
-DgRPC_PROTOBUF_PROVIDER=package
-DgRPC_SSL_PROVIDER=package
-DgRPC_RE2_PROVIDER=package
-DgRPC_ZLIB_PROVIDER=package
-DgRPC_GFLAGS_PROVIDER=package
-DRUN_HAVE_POSIX_REGEX=0
-DRUN_HAVE_STD_REGEX=0
-DRUN_HAVE_STEADY_CLOCK=0
-DProtobuf_PROTOC_LIBRARY=$MCHS_PREFIX/lib/libprotoc.so
"

mchs_step_post_get_source() {
	mchs_setup_protobuf
}

mchs_step_host_build() {
	mchs_setup_cmake
	mchs_setup_ninja

	cd $MCHS_PKG_SRCDIR
	export LD=gcc
	export LDXX=g++

	# -Wno-error=class-memaccess is used to avoid
	# src/core/lib/security/credentials/oauth2/oauth2_credentials.cc:336:61: error: ‘void* memset(void*, int, size_t)’ clearing an object of non-trivial type ‘struct grpc_oauth2_token_fetcher_credentials’; use assignment or value-initialization instead [-Werror=class-memaccess]
	# memset(c, 0, sizeof(grpc_oauth2_token_fetcher_credentials));
	# when building version 1.17.2:
	CXXFLAGS="-Wno-error=class-memaccess" \
		CFLAGS="-Wno-implicit-fallthrough" \
		cmake -G Ninja -DCMAKE_INSTALL_PREFIX=$MCHS_PKG_HOSTBUILD_DIR
	ninja -j $MCHS_MAKE_PROCESSES install
	ninja -t clean
	rm -rf CMakeCache.txt CMakeFiles
}

mchs_step_pre_configure() {
	export PATH=$MCHS_PKG_HOSTBUILD_DIR/bin:$PATH
	sed "s|@PATH_TO_PLUGIN@|$MCHS_PKG_HOSTBUILD_DIR/bin/grpc_cpp_plugin|g" \
		$MCHS_PKG_BUILDER_DIR/CMakeLists.txt.diff \
		| patch -p1
	export GRPC_CROSS_COMPILE=true
}
