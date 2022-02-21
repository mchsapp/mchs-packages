MCHS_PKG_HOMEPAGE=https://gitlab.com/opennota/findimagedupes
MCHS_PKG_DESCRIPTION="Find visually similar or duplicate images"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.20190114
MCHS_PKG_REVISION=9
_COMMIT=237ed2ef4bbb91c79eee0f5ee84a1adad9c014ff
MCHS_PKG_SRCURL=https://gitlab.com/opennota/findimagedupes/-/archive/${_COMMIT}/findimagedupes-${_COMMIT}.tar.gz
MCHS_PKG_SHA256=7eb4fbab38c8c1965dafd1d0fddbfac58ba6e1a3d52cd1220df488a0a338abb0
MCHS_PKG_DEPENDS="file, libjpeg-turbo, libpng, libtiff"
MCHS_PKG_CONFLICTS="findimagedupes"
MCHS_PKG_REPLACES="findimagedupes"

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	export CGO_CFLAGS="$CFLAGS $CPPFLAGS -I$MCHS_PREFIX/include/libpng16 -D__GLIBC__"
	export CGO_CXXFLAGS="$CXXFLAGS $CPPFLAGS -I$MCHS_PREFIX/include/libpng16 -D__GLIBC__"
	export CGO_LDFLAGS="$LDFLAGS"

	mkdir -p "$GOPATH"/src/gitlab.com/opennota
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/gitlab.com/opennota/findimagedupes

	cd "$GOPATH"/src/gitlab.com/opennota/findimagedupes

	go build .
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/gitlab.com/opennota/findimagedupes/findimagedupes \
		"$MCHS_PREFIX"/bin/findimagedupes
}
