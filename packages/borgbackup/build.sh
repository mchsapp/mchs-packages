MCHS_PKG_HOMEPAGE=https://www.borgbackup.org/
MCHS_PKG_DESCRIPTION="Deduplicating and compressing backup program"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.17
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/borgbackup/borg/releases/download/${MCHS_PKG_VERSION}/borgbackup-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=7ab924fc017b24929bedceba0dcce16d56f9868bf9b5050d2aae2eb080671674
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libacl, liblz4, openssl, python, zstd"
MCHS_PKG_BUILD_IN_SRC=true

_PYTHON_VERSION=3.10

MCHS_PKG_RM_AFTER_INSTALL="
lib/python${_PYTHON_VERSION}/site-packages/easy-install.pth
lib/python${_PYTHON_VERSION}/site-packages/site.py
lib/python${_PYTHON_VERSION}/site-packages/__pycache__
"

mchs_step_make_install() {
	export PYTHONPATH=$MCHS_PREFIX/lib/python${_PYTHON_VERSION}/site-packages
	export CPPFLAGS+=" -I${MCHS_PREFIX}/include/python${_PYTHON_VERSION}"
	export LDFLAGS+=" -lpython${_PYTHON_VERSION}"
	export LDSHARED="$CC -shared"
	export BORG_OPENSSL_PREFIX=$MCHS_PREFIX
	export BORG_LIBLZ4_PREFIX=$MCHS_PREFIX
	export BORG_LIBZSTD_PREFIX=$MCHS_PREFIX
	python${_PYTHON_VERSION} setup.py install --prefix=$MCHS_PREFIX --force
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	echo "./borgbackup-${MCHS_PKG_VERSION}-py${_PYTHON_VERSION}-linux-x86_64.egg" >> $MCHS_PREFIX/lib/python${_PYTHON_VERSION}/site-packages/easy-install.pth
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	sed -i "/\.\/borgbackup-${MCHS_PKG_VERSION}-py${_PYTHON_VERSION}-linux-x86_64\.egg/d" $MCHS_PREFIX/lib/python${_PYTHON_VERSION}/site-packages/easy-install.pth
	EOF
}
