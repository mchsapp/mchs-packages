MCHS_PKG_HOMEPAGE=http://tcl.sourceforge.net/
MCHS_PKG_DESCRIPTION="A windowing toolkit for use with tcl"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="license.terms"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.6.11.1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/tcl/tk${MCHS_PKG_VERSION}-src.tar.gz
MCHS_PKG_SHA256=006cab171beeca6a968b6d617588538176f27be232a2b334a0e96173e89909be
MCHS_PKG_DEPENDS="fontconfig, libx11, libxft, libxss, tcl"
MCHS_PKG_NO_STATICSPLIT=true
MCHS_PKG_MAKE_INSTALL_TARGET="install install-private-headers"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-threads
--enable-64bit
"

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR+="/unix"
}

mchs_step_post_make_install() {
	ln -sfr "$MCHS_PREFIX/bin/wish${MCHS_PKG_VERSION:0:3}" \
		"$MCHS_PREFIX"/bin/wish
	ln -sfr "$MCHS_PREFIX/lib/libtk${MCHS_PKG_VERSION:0:3}.so" \
		"$MCHS_PREFIX"/lib/libtk.so

	cd "$MCHS_PKG_SRCDIR"/../

	for dir in compat generic generic/ttk unix; do
		install -dm755 "$MCHS_PREFIX/include/tk-private/$dir"
		install -m644 -t "$MCHS_PREFIX/include/tk-private/$dir" "$dir"/*.h
	done
}
