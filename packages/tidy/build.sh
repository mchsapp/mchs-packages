MCHS_PKG_HOMEPAGE=http://www.html-tidy.org/
MCHS_PKG_DESCRIPTION="A tool to tidy down your HTML code to a clean style"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="README/LICENSE.md"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.8.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/htacg/tidy-html5/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=59c86d5b2e452f63c5cdb29c866a12a4c55b1741d7025cf2f3ce0cde99b0660e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libxslt"
MCHS_PKG_BREAKS="tidy-dev"
MCHS_PKG_REPLACES="tidy-dev"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	## Host build required to generate man pages.
	mchs_setup_cmake
	cmake "$MCHS_PKG_SRCDIR" && make
}

mchs_step_post_make_install() {
	install -Dm600 \
		"$MCHS_PKG_HOSTBUILD_DIR"/tidy.1 \
		"$MCHS_PREFIX"/share/man/man1/
}
