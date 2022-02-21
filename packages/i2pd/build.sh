MCHS_PKG_HOMEPAGE=https://i2pd.website/
MCHS_PKG_DESCRIPTION="A full-featured C++ implementation of the I2P router"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="../LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.41.0
MCHS_PKG_SRCURL=https://github.com/PurpleI2P/i2pd/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=7b333cd26670903ef0672cf87aa9f895814ce2bbef2e587e69d66ad9427664e6
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="boost, miniupnpc, openssl, zlib"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_UPNP:BOOL=ON"
MCHS_PKG_RM_AFTER_INSTALL="src"

MCHS_PKG_CONFFILES="
etc/i2pd/i2pd.conf
etc/i2pd/tunnels.conf
"

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR+="/build"
	CXXFLAGS="${CXXFLAGS/-Oz/-O2}"
}

mchs_step_post_make_install() {
	cd $MCHS_PKG_SRCDIR/../

	install -Dm600 -t "$MCHS_PREFIX"/etc/i2pd \
		./contrib/i2pd.conf \
		./contrib/tunnels.conf

	local _file _dir
	while read -r -d '' _file; do
		_dir="${_file#contrib/certificates}"
		_dir="${_dir%/*}"
		install -Dm600 "$_file" -t "${MCHS_PREFIX}/share/i2pd/certificates/${_dir}"
	done < <(find contrib/certificates -type f -print0)

	install -Dm600 -t "${MCHS_PREFIX}"/share/doc/i2pd/tunnels.d \
		./contrib/tunnels.d/README \
		./contrib/tunnels.d/IRC-Ilita.conf \
		./contrib/tunnels.d/IRC-Irc2P.conf

	install -Dm600 -t "${MCHS_PREFIX}"/share/man/man1 ./debian/i2pd.1
}
