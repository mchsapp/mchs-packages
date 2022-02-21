MCHS_PKG_HOMEPAGE=https://pari.math.u-bordeaux.fr/
MCHS_PKG_DESCRIPTION="A computer algebra system designed for fast computations in number theory"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.13.3
MCHS_PKG_SRCURL=https://pari.math.u-bordeaux.fr/pub/pari/unix/pari-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ccba7f1606c6854f1443637bb57ad0958d41c7f4753f8ae8459f1d64c267a1ca
MCHS_PKG_DEPENDS="gzip, libgmp, readline"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-gmp=$MCHS_PREFIX
--with-readline=$MCHS_PREFIX
"

mchs_step_pre_configure() {
	LD="$CC"
	case $MCHS_ARCH_BITS in
		32) PARI_DOUBLE_FORMAT=1 ;;
		64) PARI_DOUBLE_FORMAT=- ;;
	esac
	export PARI_DOUBLE_FORMAT
}

mchs_step_configure() {
	./Configure --prefix=$MCHS_PREFIX --host=$MCHS_HOST_PLATFORM \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS
	MCHS_PKG_EXTRA_MAKE_ARGS="-C $(echo O*)"
}
