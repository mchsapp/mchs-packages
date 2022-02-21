MCHS_PKG_HOMEPAGE=https://github.com/hashicorp/hcl
MCHS_PKG_DESCRIPTION="A toolkit for creating structured configuration languages"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.11.1
MCHS_PKG_SRCURL=https://github.com/hashicorp/hcl/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=42d7db704b311a84e455061e221a4326f996e266ebce29514714118d2a204dab
MCHS_PKG_BUILD_IN_SRC=true

_HCL_TOOLS="hcldec hclfmt hclspecsuite"

mchs_step_pre_configure() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR/_go
	mkdir -p $GOPATH
	go mod tidy
}

mchs_step_make() {
	for f in $_HCL_TOOLS; do
		go install ./cmd/$f
	done
}

mchs_step_make_install() {
	for f in $_HCL_TOOLS; do
		install -Dm700 -t $MCHS_PREFIX/bin $GOPATH/bin/*/$f
	done
}
