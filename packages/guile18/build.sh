MCHS_PKG_HOMEPAGE=http://www.gnu.org/software/guile/
MCHS_PKG_DESCRIPTION="Portable, embeddable Scheme implementation written in C. (legacy branch)"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.8.8
MCHS_PKG_REVISION=15
MCHS_PKG_SRCURL=ftp://ftp.gnu.org/pub/gnu/guile/guile-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=c3471fed2e72e5b04ad133bbaaf16369e8360283679bcf19800bc1b381024050
MCHS_PKG_DEPENDS="libcrypt, libgmp, libltdl, ncurses, readline"
MCHS_PKG_BUILD_DEPENDS="libtool"
MCHS_PKG_BREAKS="guile18-dev"
MCHS_PKG_REPLACES="guile18-dev"
MCHS_PKG_CONFLICTS="guile"
MCHS_PKG_HOSTBUILD=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--program-suffix=1.8
--disable-error-on-warning"

mchs_step_host_build() {
	mkdir HOSTBUILDINSTALL

	../src/configure \
		--prefix="$MCHS_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL \
		--program-suffix=1.8 \
		--disable-error-on-warning

	make -j "$MCHS_MAKE_PROCESSES"
	make install
}

mchs_step_pre_configure() {
	CFLAGS=${CFLAGS/Oz/Os}

	if [ $MCHS_ARCH = "i686" ]; then
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --without-threads"
	fi

	export GUILE_FOR_BUILD="$MCHS_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL/bin/guile1.8
	export LD_LIBRARY_PATH="$MCHS_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL/lib
}

mchs_step_post_make_install() {
	sed -i '1s/guile/guile1.8/' -i "$MCHS_PREFIX"/bin/guile-config1.8
	mv -f \
		"$MCHS_PREFIX"/share/aclocal/guile.m4 \
		"$MCHS_PREFIX"/share/aclocal/guile18.m4
}
