MCHS_PKG_HOMEPAGE=https://github.com/mchs/libandroid-support
MCHS_PKG_DESCRIPTION="Library extending the Android C library (Bionic) for additional multibyte, locale and math support"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_VERSION=(28
		    3)
MCHS_PKG_REVISION=2
MCHS_PKG_LICENSE_FILE="LICENSE.txt, wcwidth-${MCHS_PKG_VERSION[1]}/LICENSE.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_SRCURL=(https://github.com/mchs/libandroid-support/archive/v${MCHS_PKG_VERSION[0]}.tar.gz
		   https://github.com/mchs/wcwidth/archive/v${MCHS_PKG_VERSION[1]}.tar.gz)
MCHS_PKG_SHA256=(ef35260994ffa3bd054be66068dfc28934c823ac8de2394796d94d1cd5de3be4
		   d38062a53edb2545b9988be41bd8d217f803fa985158b7cadf95d804761dd1f6)
MCHS_PKG_PRE_DEPENDS="dpkg (>= 1.19.4-3)"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_ESSENTIAL=true

mchs_step_post_get_source() {
	cp wcwidth-${MCHS_PKG_VERSION[1]}/wcwidth.c src/
}

mchs_step_make() {
	local c_file

	mkdir -p objects
	for c_file in $(find src -type f -iname \*.c); do
		$CC $CPPFLAGS $CFLAGS -std=c99 -DNULL=0 -fPIC -Iinclude \
			-c $c_file -o ./objects/$(basename "$c_file").o
	done

	cd objects
	ar rcu ../libandroid-support.a *.o
	$CC $LDFLAGS -shared -o ../libandroid-support.so *.o
}

mchs_step_make_install() {
	install -Dm600 libandroid-support.a $MCHS_PREFIX/lib/libandroid-support.a
	install -Dm600 libandroid-support.so $MCHS_PREFIX/lib/libandroid-support.so
}
