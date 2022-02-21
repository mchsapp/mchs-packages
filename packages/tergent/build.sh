MCHS_PKG_HOMEPAGE=https://github.com/aeolwyr/tergent
MCHS_PKG_DESCRIPTION="A cryptoki/PKCS#11 library for McHs that uses Android Keystore as its backend"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/aeolwyr/tergent/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0b59cf0ced3f693fb19396a986326963f3763e6bf65d3e56af0a03d206d69428
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="mchs-api"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_make_install() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
	install -Dm600 -t $MCHS_PREFIX/lib target/${CARGO_TARGET_NAME}/release/libtergent.so
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${MCHS_PREFIX}/bin/bash
	echo
	echo "Tergent since v1.x has some breaking changes."
	echo
	echo "You will need new keys. See https://github.com/aeolwyr/tergent/blob/master/README.md#upgrading-from-01 for more details on how to upgrade."
	echo
	read -p "Are you sure you're ready to upgrade? [yN] " yn
	case \$yn in
		[Yy]* ) exit 0;;
		* ) exit 1;;
	esac
	EOF
}
