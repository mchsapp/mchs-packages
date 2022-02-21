MCHS_PKG_HOMEPAGE=https://getmonero.org/
MCHS_PKG_DESCRIPTION="A private, secure, untraceable, decentralised digital currency"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.17.3.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/monero-project/monero.git
MCHS_PKG_DEPENDS="boost, libprotobuf, libzmq, openssl, readline, unbound"

mchs_step_pre_configure() {
	mchs_setup_protobuf

	_NEED_DUMMY_LIBRT_A=
	_LIBRT_A=$MCHS_PREFIX/lib/librt.a
	if [ ! -e $_LIBRT_A ]; then
		_NEED_DUMMY_LIBRT_A=true
		echo '!<arch>' > $_LIBRT_A
	fi
}

mchs_step_post_configure() {
	local bin=$MCHS_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	$CC_FOR_BUILD \
		$MCHS_PKG_SRCDIR/translations/generate_translations_header.c \
		-o $bin/generate_translations_header_for_build
	export PATH=$bin:$PATH
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBRT_A ]; then
		rm -f $_LIBRT_A
	fi
}
