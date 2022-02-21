MCHS_PKG_HOMEPAGE=https://www.ledger-cli.org
MCHS_PKG_DESCRIPTION="Powerful, double-entry accounting system"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.2.1
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://github.com/ledger/ledger/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=92bf09bc385b171987f456fe3ee9fa998ed5e40b97b3acdd562b663aa364384a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="boost, libc++, libedit, libmpfr, libgmp, python"
MCHS_PKG_BREAKS="ledger-dev"
MCHS_PKG_REPLACES="ledger-dev"
MCHS_PKG_BUILD_DEPENDS="utf8cpp"
# See https://gitlab.kitware.com/cmake/cmake/issues/18865:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBoost_NO_BOOST_CMAKE=ON
-DUSE_PYTHON=ON
-DUTFCPP_PATH=$MCHS_PREFIX/include/utf8cpp
"
