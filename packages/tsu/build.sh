MCHS_PKG_HOMEPAGE=https://github.com/cswl/tsu
MCHS_PKG_DESCRIPTION="A su wrapper for McHs"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.6.0
_COMMIT=800b448becafb0186eecc366c50442ed9f8bb944
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_SRCURL=https://github.com/cswl/tsu.git
MCHS_PKG_GIT_BRANCH=v8

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT
}

mchs_step_make() {
	python3 ./extract_usage.py
}

mchs_step_make_install() {
	# There is no install.sh script in the repository for now
	mkdir -p "$MCHS_PREFIX/bin"
	install -Dm755 tsu "$MCHS_PREFIX/bin"
	# sudo - is an included addon in tsu now
	ln -sf "$MCHS_PREFIX/bin/tsu" "$MCHS_PREFIX/bin/sudo"
}
