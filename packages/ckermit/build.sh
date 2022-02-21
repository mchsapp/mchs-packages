MCHS_PKG_HOMEPAGE=https://www.kermitproject.org/ckermit.html
MCHS_PKG_DESCRIPTION="A combined network and serial communication software package"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="COPYING.TXT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=9.0.302
MCHS_PKG_SRCURL=http://www.columbia.edu/kermit/ftp/archives/cku${MCHS_PKG_VERSION##*.}.tar.gz
MCHS_PKG_SHA256=0d5f2cd12bdab9401b4c836854ebbf241675051875557783c332a6a40dac0711
MCHS_PKG_DEPENDS="libcrypt"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="-e linuxa"

mchs_extract_src_archive() {
	local file="$MCHS_PKG_CACHEDIR/$(basename "${MCHS_PKG_SRCURL}")"
	mkdir -p "$MCHS_PKG_SRCDIR"
	tar xf "$file" -C "$MCHS_PKG_SRCDIR" --strip-components=0
}

mchs_step_pre_configure() {
	CFLAGS+=" -fPIC"
	export KFLAGS="-DNOGETUSERSHELL -UNOTIMEH -DTIMEH -DUSE_FILE_R"
	LDFLAGS+=" -lcrypt"
	export LNKFLAGS="$LDFLAGS"
}

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/bin
	mkdir -p $MCHS_PREFIX/share/man
	make prefix=$MCHS_PREFIX manroot=$MCHS_PREFIX/share install
	install -Dm600 -t $MCHS_PREFIX/share/doc/ckermit/ *.txt
}
