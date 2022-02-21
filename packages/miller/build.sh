MCHS_PKG_HOMEPAGE=https://miller.readthedocs.io/
MCHS_PKG_DESCRIPTION="Like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.0.0
MCHS_PKG_SRCURL=https://github.com/johnkerl/miller.git
MCHS_PKG_EXTRA_MAKE_ARGS="PREFIX=$MCHS_PREFIX"

mchs_step_pre_configure() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	local dir="$GOPATH"/src/github.com/johnkerl/miller
	mkdir -p "$(dirname "${dir}")"
	ln -sfT "$MCHS_PKG_SRCDIR" "${dir}"
	MCHS_PKG_BUILDDIR="${dir}"
	cd "${dir}"
}

mchs_step_configure() {
	:
}
