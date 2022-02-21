MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/ta-lib/
MCHS_PKG_DESCRIPTION="Technical analysis library with indicators like ADX."
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://prdownloads.sourceforge.net/ta-lib/ta-lib-$MCHS_PKG_VERSION-src.tar.gz
MCHS_PKG_SHA256=9ff41efcb1c011a4b4b6dfc91610b06e39b1d7973ed5d4dee55029a0ac4dc651
MCHS_PKG_BREAKS="talib"
MCHS_PKG_REPLACES="talib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	curl https://sourceforge.net/p/ta-lib/code/HEAD/tree/tags/release-${MCHS_PKG_VERSION//./-}/ta-lib/LICENSE.TXT?format=raw -o $MCHS_PKG_SRCDIR/LICENSE
}
