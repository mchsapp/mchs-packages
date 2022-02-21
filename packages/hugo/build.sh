MCHS_PKG_HOMEPAGE=https://gohugo.io/
MCHS_PKG_DESCRIPTION="A fast and flexible static site generator"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.92.2
MCHS_PKG_SRCURL=https://github.com/gohugoio/hugo/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=00d61205f426587dcfc4e2844a6f9fb451c825b828c00f0b46e3d0930c132751
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	cd $MCHS_PKG_SRCDIR
	go build \
		-o "$MCHS_PREFIX/bin/hugo" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded

	# Building for host to generate manpages and completion.
	chmod 700 -R $GOPATH/pkg && rm -rf $GOPATH/pkg
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go build \
		-o "$MCHS_PKG_BUILDDIR/hugo" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded
}

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/share/{bash-completion/completions,zsh/site-functions,fish/vendor_completions.d,man/man1}

	$MCHS_PKG_BUILDDIR/hugo completion bash > $MCHS_PREFIX/share/bash-completion/completions/hugo
	$MCHS_PKG_BUILDDIR/hugo completion zsh > $MCHS_PREFIX/share/zsh/site-functions/_hugo
	$MCHS_PKG_BUILDDIR/hugo completion fish > $MCHS_PREFIX/share/fish/vendor_completions.d/hugo.fish

	$MCHS_PKG_BUILDDIR/hugo gen man \
		--dir=$MCHS_PREFIX/share/man/man1/
}
