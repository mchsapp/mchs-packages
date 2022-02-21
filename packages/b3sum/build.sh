MCHS_PKG_HOMEPAGE=https://github.com/BLAKE3-team/BLAKE3/tree/master/b3sum
MCHS_PKG_DESCRIPTION="A command line utility for calculating BLAKE3 hashes, similar to Coreutils tools like b2sum or md5sum"
MCHS_PKG_LICENSE="CC0-1.0"
MCHS_PKG_MAINTAINER="@medzikuser"
MCHS_PKG_VERSION=1.3.1
MCHS_PKG_SRCURL=https://github.com/BLAKE3-team/BLAKE3/archive/refs/tags/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=112becf0983b5c83efff07f20b458f2dbcdbd768fd46502e7ddd831b83550109
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_rust

	cd $MCHS_PKG_SRCDIR/b3sum

	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin $MCHS_PKG_SRCDIR/b3sum/target/${CARGO_TARGET_NAME}/release/b3sum
}
