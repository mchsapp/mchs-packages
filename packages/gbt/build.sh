MCHS_PKG_HOMEPAGE=https://github.com/jtyr/gbt
MCHS_PKG_DESCRIPTION="Highly configurable prompt builder for Bash and ZSH written in Go"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/jtyr/gbt/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b324695dc432e8e22bc257f7a6ec576f482ec418fb9c9a8301f47bfdf7766998
MCHS_PKG_AUTO_UPDATE=true
_COMMIT=29dc3dac6c06518073a8e879d2b6ec65291ddab2

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR

	mchs_setup_golang

	export GOPATH=$HOME/go
	mkdir -p $GOPATH/{bin,pkg,src/github.com/jtyr}
	ln -fs $MCHS_PKG_SRCDIR $GOPATH/src/github.com/jtyr/gbt

	go mod init gbt
	go mod tidy
	go build -ldflags="-s -w -X main.version=$MCHS_PKG_VERSION -X main.build=${_COMMIT::6}" -o $MCHS_PREFIX/bin/gbt github.com/jtyr/gbt/cmd/gbt

	mkdir -p $MCHS_PREFIX/{doc/gbt,share/gbt}
	cp -r $MCHS_PKG_SRCDIR/{sources,themes} $MCHS_PREFIX/share/gbt/
	cp -r $MCHS_PKG_SRCDIR/{LICENSE,README.md} $MCHS_PREFIX/doc/gbt/
}
