MCHS_PKG_HOMEPAGE=https://gi.readthedocs.io/
MCHS_PKG_DESCRIPTION="Uniform machine readable API"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_VERSION=1.68.0
MCHS_PKG_REVISION=4
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_SRCURL=https://github.com/GNOME/gobject-introspection/archive/refs/tags/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=13595a257df7d0b71b002ec115f1faafd3295c9516f307e2c57bd219d5cd8369
MCHS_PKG_BUILD_DEPENDS="glib, python"

mchs_step_pre_configure() {
	_PYTHON_VERSION=$(. $MCHS_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)
	MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Dpython=python${_PYTHON_VERSION}"
	echo "Applying meson.diff"
	sed "s%@PYTHON_VERSION@%$_PYTHON_VERSION%g" \
		$MCHS_PKG_BUILDER_DIR/meson.diff | patch --silent -p1

	CPPFLAGS+=" -I$MCHS_PREFIX/include/python${_PYTHON_VERSION} -I$MCHS_PREFIX/include/python${_PYTHON_VERSION}/cpython"
}

mchs_step_post_make_install() {
	soabi=cpython-${_PYTHON_VERSION//.}

	cd $MCHS_PREFIX/lib/gobject-introspection/giscanner
	m=_giscanner
	for s in $m.$soabi-*.so; do
		if [ -f $s ]; then
			mv $s $m.$soabi.so
		fi
	done
}
