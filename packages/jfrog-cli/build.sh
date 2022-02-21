MCHS_PKG_HOMEPAGE=https://jfrog.com/getcli
MCHS_PKG_DESCRIPTION="A CLI for JFrog products."
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.12.1
MCHS_PKG_SRCURL=https://github.com/jfrog/jfrog-cli/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=e7cf9aa7b31ad2958e912402ffe4b3d8b4dc8234244509f0d347947ff2ff7abd
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	cd $MCHS_PKG_SRCDIR
	go build \
		-o "$MCHS_PREFIX/bin/jfrog" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded

	# Building for host to generate manpages and completion.
	chmod 700 -R $GOPATH/pkg && rm -rf $GOPATH/pkg
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go build \
		-o "$MCHS_PKG_BUILDDIR/jfrog" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded
}

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/share/bash-completion/completions
	export JFROG_CLI_HOME_DIR=$MCHS_PKG_BUILDDIR/.jfrog
	$MCHS_PKG_BUILDDIR/jfrog completion bash
	cp $MCHS_PKG_BUILDDIR/.jfrog/jfrog_bash_completion $MCHS_PREFIX/share/bash-completion/completions/jfrog

}
