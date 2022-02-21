MCHS_PKG_HOMEPAGE=https://musicbrainz.org/doc/libmusicbrainz
MCHS_PKG_DESCRIPTION="The MusicBrainz Client Library"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=()
MCHS_PKG_VERSION+=(5.1.0)
MCHS_PKG_VERSION+=(2.9.12) # libxml2 version
MCHS_PKG_VERSION+=(0.32.1) # libneon version
MCHS_PKG_SRCURL=(https://github.com/metabrainz/libmusicbrainz/releases/download/release-${MCHS_PKG_VERSION}/libmusicbrainz-${MCHS_PKG_VERSION}.tar.gz
                   ftp://xmlsoft.org/libxml2/libxml2-${MCHS_PKG_VERSION[1]}.tar.gz
                   https://notroj.github.io/neon/neon-${MCHS_PKG_VERSION[2]}.tar.gz)
MCHS_PKG_SHA256=(6749259e89bbb273f3f5ad7acdffb7c47a2cf8fcaeab4c4695484cef5f4c6b46
                   c8d6681e38c56f172892c85ddc0852e1fd4b53b4209e7f4ebf17f7e2eae71d92
                   05c54bc115030c89e463a4fb28d3a3f8215879528ba5ca70d676d3d21bf3af52)
MCHS_PKG_DEPENDS="libc++, libneon, libxml2"
MCHS_PKG_HOSTBUILD=true

mchs_step_post_get_source() {
	mv libxml2-${MCHS_PKG_VERSION[1]} libxml2
	mv neon-${MCHS_PKG_VERSION[2]} neon
}

mchs_step_host_build() {
	_PREFIX_FOR_BUILD=$MCHS_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD
	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	mkdir libxml2
	pushd libxml2
	$MCHS_PKG_SRCDIR/libxml2/configure --prefix=$_PREFIX_FOR_BUILD \
		--without-python
	make -j $MCHS_MAKE_PROCESSES
	make install
	popd

	mkdir neon
	pushd neon
	$MCHS_PKG_SRCDIR/neon/configure --prefix=$_PREFIX_FOR_BUILD \
		--with-libxml2
	make -j $MCHS_MAKE_PROCESSES
	make install
	popd

	mchs_setup_cmake

	cmake $MCHS_PKG_SRCDIR
	make -j $MCHS_MAKE_PROCESSES

	unset PKG_CONFIG_PATH
}

mchs_step_pre_configure() {
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DIMPORT_EXECUTABLES=$MCHS_PKG_HOSTBUILD_DIR/ImportExecutables.cmake"
}
