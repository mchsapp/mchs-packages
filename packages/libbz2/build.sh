MCHS_PKG_HOMEPAGE=http://www.bzip.org/
MCHS_PKG_DESCRIPTION="BZ2 format compression library"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.8
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/bzip2-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=47fd74b2ff83effad0ddf62074e6fad1f6b4a77a96e121ab421c20a216371a1f
MCHS_PKG_BREAKS="libbz2-dev"
MCHS_PKG_REPLACES="libbz2-dev"
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_EXTRA_MAKE_ARGS="PREFIX=$MCHS_PREFIX"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# bzip2 does not use configure. But place man pages at correct path:
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" $MCHS_PKG_SRCDIR/Makefile
}

mchs_step_make() {
	# bzip2 uses a separate makefile for the shared library
	make -f Makefile-libbz2_so
}

mchs_step_make_install() {
	# The shared library makefile contains no install makefile, so issue a normal install to get scripts
	make $MCHS_PKG_EXTRA_MAKE_ARGS install

	# Clean out statically linked binaries and libs and replace them with shared ones:
	rm -Rf $MCHS_PREFIX/lib/libbz2*
	rm -Rf $MCHS_PREFIX/bin/{bzcat,bunzip2}
	cp bzip2-shared $MCHS_PREFIX/bin/bzip2
	cp libbz2.so.${MCHS_PKG_VERSION} $MCHS_PREFIX/lib
	(cd $MCHS_PREFIX/lib && ln -s libbz2.so.${MCHS_PKG_VERSION} libbz2.so.1.0)
	(cd $MCHS_PREFIX/lib && ln -s libbz2.so.${MCHS_PKG_VERSION} libbz2.so)
	(cd $MCHS_PREFIX/bin && ln -s bzip2 bzcat)
	(cd $MCHS_PREFIX/bin && ln -s bzip2 bunzip2)
	# bzgrep should be enough so remove bz{e,f}grep
	rm $MCHS_PREFIX/bin/bz{e,f}grep $MCHS_PREFIX/share/man/man1/bz{e,f}grep.1
}
