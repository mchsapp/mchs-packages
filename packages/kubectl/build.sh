MCHS_PKG_HOMEPAGE=https://kubernetes.io/
MCHS_PKG_DESCRIPTION="Kubernetes.io client binary"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.22.0
MCHS_PKG_SRCURL=https://dl.k8s.io/v$MCHS_PKG_VERSION/kubernetes-src.tar.gz
MCHS_PKG_SHA256=2d990278e85dade29513fc988f7f8105239dadbe5d94d03f40c18d48eb9c50e0

mchs_step_get_source() {
	mkdir -p "$MCHS_PKG_CACHEDIR"
	mkdir -p "$MCHS_PKG_SRCDIR"

	mchs_download "$MCHS_PKG_SRCURL" "$MCHS_PKG_CACHEDIR"/kubernetes-src.tar.gz \
		"$MCHS_PKG_SHA256"

	tar xf "$MCHS_PKG_CACHEDIR"/kubernetes-src.tar.gz \
		-C "$MCHS_PKG_SRCDIR"
}

mchs_step_make() {
	mchs_setup_golang

	# Needed to generate manpages.
	#(
	#	export GOPATH="$MCHS_PKG_BUILDDIR/host"
	#	unset GOOS GOARCH CGO_LDFLAGS
	#	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	#	cd "$MCHS_PKG_SRCDIR"
	#	./hack/update-generated-docs.sh
	#)

	export GOPATH="$MCHS_PKG_BUILDDIR/target"
	#chmod +w "$MCHS_PKG_SRCDIR"/_output
	#rm -rf "$MCHS_PKG_SRCDIR"/_output

	cd "$MCHS_PKG_SRCDIR"/cmd/kubectl
	go build .
}

mchs_step_make_install() {
	install -Dm700 "$MCHS_PKG_SRCDIR"/cmd/kubectl/kubectl \
		"$MCHS_PREFIX"/bin/kubectl

	#mkdir -p "$MCHS_PREFIX"/share/man/man1
	#cp -f "$MCHS_PKG_SRCDIR"/docs/man/man1/kubectl-*.1 \
	#	"$MCHS_PREFIX"/share/man/man1/
}
