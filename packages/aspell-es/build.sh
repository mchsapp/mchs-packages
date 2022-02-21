MCHS_PKG_HOMEPAGE=http://aspell.net/
MCHS_PKG_DESCRIPTION="Spanish dictionary for aspell"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="Copyright"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2:1.11-2
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/dict/es/aspell6-es-${MCHS_PKG_VERSION:2}.tar.bz2
MCHS_PKG_SHA256=ad367fa1e7069c72eb7ae37e4d39c30a44d32a6aa73cedccbd0d06a69018afcc
MCHS_PKG_DEPENDS="aspell"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_configure() {
	cat > $MCHS_PKG_SRCDIR/Makefile <<- EOF
	ASPELL = `command -v aspell`
	ASPELL_FLAGS = 
	PREZIP = `command -v prezip`
	DESTDIR =
	dictdir = $MCHS_PREFIX/lib/aspell-0.60
	datadir = $MCHS_PREFIX/lib/aspell-0.60
	EOF
	cat $MCHS_PKG_SRCDIR/Makefile.pre >> $MCHS_PKG_SRCDIR/Makefile
}
