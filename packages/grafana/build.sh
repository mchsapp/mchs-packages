MCHS_PKG_HOMEPAGE=https://grafana.com/
MCHS_PKG_DESCRIPTION="The open-source platform for monitoring and observability"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.3.4
MCHS_PKG_SRCURL=https://github.com/grafana/grafana.git
MCHS_PKG_BUILD_DEPENDS="yarn"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_setup_golang

	local bin=$MCHS_PKG_BUILDDIR/_bin
	mkdir -p $bin
	GOOS=linux GOARCH=amd64 go build build.go
	mv build $bin/_build
	local goexec=$bin/go_$(go env GOOS)_$(go env GOARCH)_exec
	cat > $goexec <<-EOF
		#!$(command -v sh)
		shift
		exec $bin/_build -goos=$GOOS -goarch=$GOARCH "\$@"
		EOF
	chmod 0755 $goexec

	local yarn=$bin/yarn
	cat > $yarn <<-EOF
		#!$(command -v sh)
		exec sh $MCHS_PREFIX/bin/yarn "\$@"
		EOF
	chmod 0755 $yarn

	export PATH=$bin:$PATH

	export NODE_OPTIONS=--max-old-space-size=6000
}

mchs_step_make() {
	make build-go
	make deps-js
	make build-js
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin bin/*/grafana-server bin/*/grafana-cli
	local sharedir=$MCHS_PREFIX/share/grafana
	mkdir -p $sharedir
	for d in conf public; do
		cp -rT $d $sharedir/$d
	done
}
