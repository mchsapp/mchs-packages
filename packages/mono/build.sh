MCHS_PKG_HOMEPAGE=https://www.mono-project.com/
MCHS_PKG_DESCRIPTION="Cross platform, open source .NET framework"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.12.0.122
MCHS_PKG_SRCURL=https://download.mono-project.com/sources/mono/mono-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=29c277660fc5e7513107aee1cbf8c5057c9370a4cdfeda2fc781be6986d89d23
MCHS_PKG_DEPENDS="krb5, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-btls
--without-ikvm-native
"
MCHS_PKG_HOSTBUILD=true

mchs_step_post_get_source() {
	rm -f external/bdwgc/config.status
}

mchs_step_host_build() {
	_PREFIX_FOR_BUILD=$MCHS_PKG_HOSTBUILD_DIR/_prefix
	mkdir -p $_PREFIX_FOR_BUILD
	$MCHS_PKG_SRCDIR/configure --prefix=$_PREFIX_FOR_BUILD \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS
	make -j $MCHS_MAKE_PROCESSES
	make install
}

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH" == "arm" ]; then
		CFLAGS="${CFLAGS//-mthumb/}"
	fi
	LDFLAGS+=" -lgssapi_krb5"
}

mchs_step_post_make_install() {
	find $_PREFIX_FOR_BUILD/lib/mono -name '*.so' -exec rm -f \{\} \;
	cp -rT $_PREFIX_FOR_BUILD/lib/mono $MCHS_PREFIX/lib/mono
}
