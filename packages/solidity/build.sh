MCHS_PKG_HOMEPAGE=https://solidity.readthedocs.io
MCHS_PKG_DESCRIPTION="An Ethereum smart contract-oriented language."
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.12
MCHS_PKG_SRCURL=https://github.com/ethereum/solidity/releases/download/v${MCHS_PKG_VERSION}/solidity_${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c63c2caf64feaef9fbde7c8d26e3d15aa9b159d08e7213e1e6bd3e4fd06c8308
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="boost, jsoncpp"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_Z3=OFF
-DUSE_CVC4=OFF
-DUSE_LD_GOLD=OFF
-DBoost_USE_STATIC_LIBS=OFF
"
MCHS_CMAKE_BUILD="Unix Makefiles"

mchs_step_pre_configure() {
	LDFLAGS+=" -ljsoncpp"
}
