MCHS_PKG_HOMEPAGE=https://wiki.debian.org/apt-file
MCHS_PKG_DESCRIPTION="search for files within packages"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.2.2
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=http://deb.debian.org/debian/pool/main/a/apt-file/apt-file_${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=bacbfb038dca6d2f0b740dcd05064d0b81fd0f086ce2eb59c5157d13ef064edf
MCHS_PKG_DEPENDS="apt, libapt-pkg-perl, libregexp-assemble-perl, perl"
MCHS_PKG_REPLACES="whatprovides"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_EXTRA_MAKE_ARGS="DESTDIR=$MCHS_PREFIX BINDIR=$MCHS_PREFIX/bin \
				MANDIR=$MCHS_PREFIX/share/man/man1"


mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/etc/bash_completion.d/
	cp $MCHS_PKG_SRCDIR/debian/bash-completion \
	   $MCHS_PREFIX/etc/bash_completion.d/apt-file
}
