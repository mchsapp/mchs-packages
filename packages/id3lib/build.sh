MCHS_PKG_HOMEPAGE=http://id3lib.sourceforge.net/
MCHS_PKG_DESCRIPTION="A software library for manipulating ID3v1/v1.1 and ID3v2 tags"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.8.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/id3lib/id3lib-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2749cc3c0cd7280b299518b1ddf5a5bcfe2d1100614519b68702230e26c7d079
MCHS_PKG_DEPENDS="libc++, libiconv, zlib"

mchs_step_pre_configure() {
	for f in examples/demo_*.cpp; do
		sed -i -e 's/^int main( unsigned int /int main( int /g' $f
	done

	_ID3LIB_MAJOR=$(awk -F= '/^ID3LIB_MAJOR_/ { print $2 }' configure.in)
	_ID3LIB_MINOR=$(awk -F= '/^ID3LIB_MINOR_/ { print $2 }' configure.in)

	aclocal
	automake --add-missing
	autoreconf -fi
}

mchs_step_post_make_install() {
	_LIBID3_SO=libid3-${_ID3LIB_MAJOR}.${_ID3LIB_MINOR}.so
	if [ ! -e $MCHS_PREFIX/lib/$_LIBID3_SO ]; then
		echo "ERROR: $_LIBID3_SO not found."
		return 1
	fi
	ln -sf $_LIBID3_SO $MCHS_PREFIX/lib/libid3.so
}
