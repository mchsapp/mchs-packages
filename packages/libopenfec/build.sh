MCHS_PKG_HOMEPAGE=http://openfec.org
MCHS_PKG_DESCRIPTION="Application-Level Forward Erasure Correction implementation library"
MCHS_PKG_LICENSE="CeCILL-C"
MCHS_PKG_LICENSE_FILE="LICENCE_CeCILL-C_V1-en.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.2.4
MCHS_PKG_REVISION=10
MCHS_PKG_SRCURL=https://github.com/roc-project/openfec/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=691e3ec41b948e93dd34c690139624e2e20ed390e6a5f000f238491574343a16
MCHS_PKG_BREAKS="libopenfec-dev"
MCHS_PKG_REPLACES="libopenfec-dev"

mchs_step_make_install() {
	install -Dm600 "$MCHS_PKG_SRCDIR/bin/Release/libopenfec.so" "$MCHS_PREFIX/lib/libopenfec.so"

	cd $MCHS_PKG_SRCDIR/src
	local include; for include in $(find . -type f -iname \*.h | sed 's@^\./@@'); do
		install -Dm600 "$include" "$MCHS_PREFIX"/include/openfec/"$include"
	done
}
