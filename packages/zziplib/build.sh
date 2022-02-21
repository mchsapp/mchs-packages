MCHS_PKG_HOMEPAGE=http://zziplib.sourceforge.net/
MCHS_PKG_DESCRIPTION="Provides read access to zipped files in a zip-archive, using compression based on free algorithms"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.13.72
MCHS_PKG_SRCURL=https://github.com/gdraheim/zziplib/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=93ef44bf1f1ea24fc66080426a469df82fa631d13ca3b2e4abaeab89538518dc
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DZZIPTEST=off -DZZIPDOCS=off"
MCHS_PKG_DEPENDS="zlib"

mchs_step_post_make_install() {
	cd $MCHS_PREFIX/lib
	for lib in zzip zzipfseeko zzipmmapped zzipwrap; do
		ln -sf lib${lib}-0.so lib${lib}.so
	done
}
