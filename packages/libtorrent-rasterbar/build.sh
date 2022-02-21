MCHS_PKG_HOMEPAGE=https://libtorrent.org/
MCHS_PKG_DESCRIPTION="A feature complete C++ bittorrent implementation focusing on efficiency and scalability"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.5
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/arvidn/libtorrent/releases/download/v${MCHS_PKG_VERSION}/libtorrent-rasterbar-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e965c2e53170c61c0db3a2d898a61769cb7acd541bbf157cbbef97a185930ea5
MCHS_PKG_DEPENDS="boost, openssl, python"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dboost-python-module-name=python
-Dpython-bindings=ON
"

mchs_step_pre_configure() {
	_PYTHON_VERSION=$(. $MCHS_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)
	LDFLAGS+=" -lpython${_PYTHON_VERSION}"
}

mchs_step_create_debscripts() {
	local pyext_orig="$MCHS_PREFIX/lib/python${_PYTHON_VERSION%.*}/dist-packages/libtorrent.so"
	local pyext_symlink="$MCHS_PREFIX/lib/python${_PYTHON_VERSION}/site-packages/libtorrent.so"

	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "pyext_orig=\"$pyext_orig\"" >> postinst
	echo "pyext_symlink=\"$pyext_symlink\"" >> postinst
	echo "mkdir -p \"\$(dirname \"\$pyext_symlink\")\"" >> postinst
	echo "if [ ! -e \"\$pyext_symlink\" ]; then" >> postinst
	echo "  ln -sf \"\$pyext_orig\" \"\$pyext_symlink\"" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst

	echo "#!$MCHS_PREFIX/bin/sh" > prerm
	echo "pyext_orig=\"$pyext_orig\"" >> prerm
	echo "pyext_symlink=\"$pyext_symlink\"" >> prerm
	echo "if [ -L \"\$pyext_symlink\" ]; then" >> prerm
	echo "  if [ \"\$(readlink \"\$pyext_symlink\")\" == \"\$pyext_orig\" ]; then" >> prerm
	echo "    rm -f \"\$pyext_symlink\"" >> prerm
	echo "  fi" >> prerm
	echo "fi" >> prerm
	echo "exit 0" >> prerm
	chmod 0755 prerm
}
