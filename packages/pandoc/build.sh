MCHS_PKG_HOMEPAGE=https://pandoc.org/
MCHS_PKG_DESCRIPTION="Universal markup converter"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.16.1
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_make_install() {
	local srcurl
	local sha256

	case "$MCHS_ARCH" in
		aarch64)
			srcurl="https://github.com/jgm/pandoc/releases/download/${MCHS_PKG_VERSION}/pandoc-${MCHS_PKG_VERSION}-linux-arm64.tar.gz"
			sha256="c1130d917fb6e8c9a29cadc52ef9e4c4405450868d5f7dd3018f413755ac2b31"
			;;
		x86_64)
			srcurl="https://github.com/jgm/pandoc/releases/download/${MCHS_PKG_VERSION}/pandoc-${MCHS_PKG_VERSION}-linux-amd64.tar.gz"
			sha256="3fe3d42179af289d4f5452b9317d2bc9cd139a4f33a37f68d70e128f1d415aa4"
			;;
		*)
			mchs_error_exit "Unsupported arch: $MCHS_ARCH"
			;;
	esac

	mchs_download "$srcurl" "pandoc-${MCHS_PKG_VERSION}.tar.gz" "$sha256"
	tar xf "pandoc-${MCHS_PKG_VERSION}.tar.gz"
	cd "pandoc-${MCHS_PKG_VERSION}"

	install -Dm700 "./bin/pandoc" "$MCHS_PREFIX/bin/pandoc"
	install -Dm600 "./share/man/man1/pandoc.1.gz" "$MCHS_PREFIX/share/man/man1/pandoc.1.gz"
}
