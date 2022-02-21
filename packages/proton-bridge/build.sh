MCHS_PKG_HOMEPAGE=https://github.com/ProtonMail/proton-bridge
MCHS_PKG_DESCRIPTION="ProtonMail Bridge application"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_VERSION=1.8.10
MCHS_PKG_SRCURL=https://github.com/ProtonMail/proton-bridge.git
MCHS_PKG_GIT_BRANCH=br-$MCHS_PKG_VERSION
MCHS_PKG_MAINTAINER="Radomír Polách <rp@t4d.cz>"
MCHS_PKG_DEPENDS=libsecret

# On 32bit arches we get:
# ../build/pkg/mod/github.com/!proton!mail/go-rfc5322@v0.8.0/parser/rfc5322_parser.go:2756: constant 4230534781 overflows int
# ../build/pkg/mod/github.com/!proton!mail/go-rfc5322@v0.8.0/parser/rfc5322_parser.go:2780: constant 4230534781 overflows int
# ../build/pkg/mod/github.com/!proton!mail/go-rfc5322@v0.8.0/parser/rfc5322_parser.go:6683: constant 2740715144 overflows int
# ../build/pkg/mod/github.com/!proton!mail/go-rfc5322@v0.8.0/parser/rfc5322_parser.go:6683: constant 4294967167 overflows int
# ../build/pkg/mod/github.com/!proton!mail/go-rfc5322@v0.8.0/parser/rfc5322_parser.go:11728: constant 4244674173 overflows int
# ../build/pkg/mod/github.com/!proton!mail/go-rfc5322@v0.8.0/parser/rfc5322_parser.go:12153: constant 4292870143 overflows int
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR
	cd $MCHS_PKG_SRCDIR

	make build-nogui
}

mchs_step_make_install() {
	install -Dm700 $MCHS_PKG_SRCDIR/proton-bridge \
		"$MCHS_PREFIX"/bin/proton-bridge
}
