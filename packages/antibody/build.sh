MCHS_PKG_HOMEPAGE=https://github.com/getantibody/antibody
MCHS_PKG_DESCRIPTION="The fastest shell plugin manager"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.1.1
MCHS_PKG_SRCURL=https://github.com/getantibody/antibody/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=87bced5fba8cf5d587ea803d33dda72e8bcbd4e4c9991a9b40b2de4babbfc24f
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/getantibody
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/getantibody/antibody

	cd "$GOPATH"/src/github.com/getantibody/antibody
	go build
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/getantibody/antibody/antibody \
		"$MCHS_PREFIX"/bin/
}
