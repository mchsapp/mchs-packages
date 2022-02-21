MCHS_PKG_HOMEPAGE=https://www.softether.org/
MCHS_PKG_DESCRIPTION="An open-source cross-platform multi-protocol VPN program"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=(5.02.5180)
MCHS_PKG_VERSION+=(1.0.18)
MCHS_PKG_SRCURL=(https://github.com/SoftEtherVPN/SoftEtherVPN/releases/download/${MCHS_PKG_VERSION}/SoftEtherVPN-${MCHS_PKG_VERSION}.tar.xz
                   https://github.com/jedisct1/libsodium/archive/${MCHS_PKG_VERSION[1]}-RELEASE.tar.gz)
MCHS_PKG_SHA256=(b5649a8ea3cc6477325e09e2248ef708d434ee3b2251eb8764bcfc15fb1de456
                   b7292dd1da67a049c8e78415cd498ec138d194cfdb302e716b08d26b80fecc10)
MCHS_PKG_DEPENDS="libiconv, libsodium, ncurses, openssl, readline, zlib"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DHAS_SSE2=OFF
"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_RM_AFTER_INSTALL="lib/systemd"

mchs_step_post_get_source() {
	mv libsodium-${MCHS_PKG_VERSION[1]}-RELEASE libsodium
}

mchs_step_host_build() {
	local _PREFIX_FOR_BUILD=$MCHS_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD
	mkdir -p libsodium
	pushd libsodium
	$MCHS_PKG_SRCDIR/libsodium/configure --prefix=$_PREFIX_FOR_BUILD
	make -j $MCHS_MAKE_PROCESSES
	make install
	popd

	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	mchs_setup_cmake
	cmake $MCHS_PKG_SRCDIR
	make -j $MCHS_MAKE_PROCESSES

	unset PKG_CONFIG_PATH
}

mchs_step_post_configure() {
	export PATH=$MCHS_PKG_HOSTBUILD_DIR/src/hamcorebuilder:$PATH
}
