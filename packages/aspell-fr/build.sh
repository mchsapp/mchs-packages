MCHS_PKG_HOMEPAGE=http://aspell.net/
MCHS_PKG_DESCRIPTION="French dictionary for aspell"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2:0.50-3
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/dict/fr/aspell-fr-${MCHS_PKG_VERSION:2}.tar.bz2
MCHS_PKG_SHA256=f9421047519d2af9a7a466e4336f6e6ea55206b356cd33c8bd18cb626bf2ce91
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
