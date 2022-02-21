MCHS_PKG_HOMEPAGE=https://elixir-lang.org/
MCHS_PKG_DESCRIPTION="Elixir is a dynamic, functional language designed for building scalable and maintainable applications"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.13.3
MCHS_PKG_SRCURL=https://github.com/elixir-lang/elixir/releases/download/v${MCHS_PKG_VERSION}/Precompiled.zip
MCHS_PKG_SHA256=0b740bedbfdb1621c129dfd45238c5d6d0e754787faa70ec327a95112bc403a9
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="dash, erlang"
MCHS_PKG_SUGGESTS="clang, make"
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_get_source() {
	mchs_download "$MCHS_PKG_SRCURL" "$MCHS_PKG_CACHEDIR"/prebuilt.zip \
		"$MCHS_PKG_SHA256"
	# Create src directory to avoid build-package.sh errors.
	mkdir -p "$MCHS_PKG_SRCDIR"
}

mchs_step_make_install() {
	# Unpack directly to $PREFIX/opt/elixir.
	mkdir -p "$MCHS_PREFIX"/opt
	rm -rf "$MCHS_PREFIX"/opt/elixir
	unzip -d "$MCHS_PREFIX"/opt/elixir "$MCHS_PKG_CACHEDIR"/prebuilt.zip

	# Remove unneeded files.
	(cd "$MCHS_PREFIX"/opt/elixir/man; rm -f common elixir.1.in iex.1.in)

	# Put manpages to standard location.
	for page in elixir.1 elixirc.1 iex.1 mix.1; do
		install -Dm600 "$MCHS_PREFIX/opt/elixir/man/$page" \
			"$MCHS_PREFIX/share/man/man1/$page"
	done
	unset page
	rm -rf "$MCHS_PREFIX"/opt/elixir/man

	# Symlink startup scripts to $PREFIX/bin.
	for file in elixir elixirc iex mix; do
		ln -sfr "$MCHS_PREFIX/opt/elixir/bin/$file" \
			"$MCHS_PREFIX/bin/$file"
	done
	unset file
}
