MCHS_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3key.html
MCHS_PKG_DESCRIPTION="A library and database with escape sequence to key symbol mappings"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2.10
MCHS_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3key-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=b3f63c8a5bdf4efc10a293e5124a4a1095af6149af96b0a10b3ce7da7400f8c1
MCHS_PKG_DEPENDS="libt3config, ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"
MCHS_PKG_HOSTBUILD=true

mchs_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
}

mchs_step_host_build() {
	_PREFIX_FOR_BUILD=$MCHS_PKG_HOSTBUILD_DIR/_prefix
	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	local LIBT3CONFIG_BUILD_SH=$MCHS_SCRIPTDIR/packages/libt3config/build.sh
	local LIBT3CONFIG_SRCURL=$(bash -c ". $LIBT3CONFIG_BUILD_SH; echo \$MCHS_PKG_SRCURL")
	local LIBT3CONFIG_SHA256=$(bash -c ". $LIBT3CONFIG_BUILD_SH; echo \$MCHS_PKG_SHA256")
	local LIBT3CONFIG_TARFILE=$MCHS_PKG_CACHEDIR/$(basename $LIBT3CONFIG_SRCURL)
	mchs_download $LIBT3CONFIG_SRCURL $LIBT3CONFIG_TARFILE $LIBT3CONFIG_SHA256

	mkdir -p libt3config
	pushd libt3config
	tar xf $LIBT3CONFIG_TARFILE --strip-components=1
	./configure --prefix=$_PREFIX_FOR_BUILD --without-gettext
	make -j $MCHS_MAKE_PROCESSES
	make install
	popd

	mkdir -p libt3key
	pushd libt3key
	find $MCHS_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	./configure --prefix=$_PREFIX_FOR_BUILD --without-gettext \
		LDFLAGS="-Wl,-rpath=$_PREFIX_FOR_BUILD/lib"
	make -j $MCHS_MAKE_PROCESSES
	make install
	popd

	unset PKG_CONFIG_PATH
}

mchs_step_pre_configure() {
	export PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	local libtooldir=$MCHS_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$MCHS_SCRIPTDIR/scripts/config.sub" ./
	cp "$MCHS_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$MCHS_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool
}
