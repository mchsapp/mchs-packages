MCHS_PKG_HOMEPAGE=https://asciidoctor.org/
MCHS_PKG_DESCRIPTION="An implementation of AsciiDoc in Ruby"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.16
MCHS_PKG_DEPENDS="ruby"
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

_RUBY_VERSION=2.7


mchs_step_make_install() {
	local gemdir="$MCHS_PREFIX/lib/ruby/gems/${_RUBY_VERSION}.0"

	rm -rf "$gemdir/asciidoctor-$MCHS_PKG_VERSION"
	rm -rf "$gemdir/doc/asciidoctor-$MCHS_PKG_VERSION"

	gem install --ignore-dependencies --no-user-install --verbose \
		-i "$gemdir" -n "$MCHS_PREFIX/bin" asciidoctor -v "$MCHS_PKG_VERSION"

	sed -i -E "1 s@^(#\!)(.*)@\1${MCHS_PREFIX}/bin/ruby@" \
		"$MCHS_PREFIX/bin/asciidoctor"

	install -Dm600 "$gemdir/gems/asciidoctor-${MCHS_PKG_VERSION}/man/asciidoctor.1" \
		"$MCHS_PREFIX/share/man/main1/asciidoctor.1"
}

mchs_step_install_license() {
	local gemdir="$MCHS_PREFIX/lib/ruby/gems/${_RUBY_VERSION}.0"
	mkdir -p $MCHS_PREFIX/share/doc/asciidoctor
	cp $gemdir/gems/asciidoctor-${MCHS_PKG_VERSION}/LICENSE $MCHS_PREFIX/share/doc/asciidoctor/
}
