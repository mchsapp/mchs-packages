MCHS_PKG_HOMEPAGE=https://github.com/Canop/broot
MCHS_PKG_DESCRIPTION="A better way to navigate directories"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.8.0
MCHS_PKG_SRCURL=https://github.com/Canop/broot/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=baa107a2cd458c9f4eda9cafa8fac54570918efafaadfc34df43442f7cd237b9
MCHS_PKG_DEPENDS="libgit2"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release

	mkdir -p build
	cp man/page build/broot.1
	sed -i "s/#version/$MCHS_PKG_VERSION/g" build/broot.1
	sed -i "s/#date/$(date -r man/page +'%Y\/%m\/%d')/g" build/broot.1

}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/broot
	install -Dm644 -t $MCHS_PREFIX/share/man/man1 build/broot.1
}
