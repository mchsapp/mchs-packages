MCHS_PKG_HOMEPAGE=https://github.com/bitcoin-core/secp256k1
MCHS_PKG_DESCRIPTION="Optimized c library for ECDSA signatures and seret/public key operations on curve secp256k1"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20200902
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/bitcoin-core/secp256k1/archive/f49c9896b0d03d7dc45515260760659879c5728e.tar.gz
MCHS_PKG_SHA256=941b63f4d35ff231f477e96b738759c4943731183c3cf8a586768c1010315882
MCHS_PKG_BUILD_IN_SRC=true

# These flags are suggested by electrum
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-module-recovery
--enable-experimental
--enable-module-ecdh
"

mchs_step_pre_configure() {
	autoreconf -vfi
}
