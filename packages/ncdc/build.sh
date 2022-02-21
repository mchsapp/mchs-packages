MCHS_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdc
MCHS_PKG_DESCRIPTION="Modern and lightweight direct connect client with a friendly ncurses interface"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.22.1
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://dev.yorhel.nl/download/ncdc-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d15fd378aa345f423e59a38691c668f69b516cd4b8afbbcdc446007740c3afad
MCHS_PKG_DEPENDS="libandroid-support, libiconv, libgnutls, libsqlite, bzip2, glib, ncurses, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_configure() {
	# Cross compiling steps documented in ncdc README
	gcc $MCHS_PKG_SRCDIR/deps/makeheaders.c -o makeheaders
	gcc -I. $MCHS_PKG_SRCDIR/doc/gendoc.c -o gendoc
	touch -d "next hour" makeheaders gendoc
}
