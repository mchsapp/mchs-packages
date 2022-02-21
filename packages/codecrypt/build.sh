MCHS_PKG_HOMEPAGE=http://e-x-a.org/codecrypt/
MCHS_PKG_DESCRIPTION="The post-quantum cryptography tool"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.8
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://github.com/exaexa/codecrypt/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=25f11bc361b4f8aca7245698334b5715b7d594d708a75e8cdb2aa732dc46eb96
MCHS_PKG_DEPENDS="cryptopp, fftw, libgmp"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-cryptopp"

mchs_step_pre_configure() {
	./autogen.sh
	export LIBS="-lm"
	export CRYPTOPP_CFLAGS="-I$MCHS_PREFIX/include"
	export CRYPTOPP_LIBS="-L$MCHS_PREFIX/lib -lcryptopp"
}
