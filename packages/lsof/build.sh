MCHS_PKG_HOMEPAGE=https://github.com/lsof-org/lsof
MCHS_PKG_DESCRIPTION="Lists open files for running Unix processes"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.94.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/lsof-org/lsof/archive/${MCHS_PKG_VERSION}/lsof-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a9865eeb581c3abaac7426962ddb112ecfd86a5ae93086eb4581ce100f8fa8f4
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libandroid-support, libtirpc"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	LSOF_CC="$CC" ./Configure -n linux
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin/ lsof
	install -Dm600 Lsof.8 $MCHS_PREFIX/share/man/man8/lsof.8
}

mchs_step_install_license() {
	install -Dm600 -t $MCHS_PREFIX/share/doc/lsof $MCHS_PKG_BUILDER_DIR/license.txt
}
