MCHS_PKG_HOMEPAGE=http://aspell.net/
MCHS_PKG_DESCRIPTION="English dictionary for aspell"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="Copyright"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:2020.12.07
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-${MCHS_PKG_VERSION:2}-0.tar.bz2
MCHS_PKG_SHA256=4c8f734a28a088b88bb6481fcf972d0b2c3dc8da944f7673283ce487eac49fb3
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
