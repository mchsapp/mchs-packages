MCHS_PKG_HOMEPAGE=https://github.com/gokcehan/lf
MCHS_PKG_DESCRIPTION="Terminal file manager"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=26
MCHS_PKG_SRCURL=https://github.com/gokcehan/lf/archive/r$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=dccd1ad67d2639e47fe0cbc93d74f202d6d6f0c3759fb0237affb7b1a2b1379e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+"
MCHS_PKG_CONFFILES="etc/lf/lfrc"

mchs_step_make() {
	mchs_setup_golang
	export GOPATH="$MCHS_PKG_BUILDDIR"
	mkdir -p "$GOPATH/src/github.com/gokcehan"
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH/src/github.com/gokcehan/lf"
	cd "$GOPATH/src/github.com/gokcehan/lf"
	go build -ldflags="-X main.gVersion=r$MCHS_PKG_VERSION" -trimpath
}

mchs_step_make_install() {
	cd "$GOPATH/src/github.com/gokcehan/lf"
	install -Dm755 -t "$MCHS_PREFIX/bin" lf
	install -Dm644 -T etc/lfrc.example "$MCHS_PREFIX/etc/lf/lfrc"
	install -Dm644 -t "$MCHS_PREFIX/share/applications" lf.desktop
	install -Dm644 -t "$MCHS_PREFIX/share/doc/lf" README.md
	install -Dm644 -t "$MCHS_PREFIX/share/man/man1" lf.1
	# bash integration
	install -Dm644 -t "$MCHS_PREFIX/etc/profile.d" etc/lfcd.sh
	# csh integration
	install -Dm644 -t "$MCHS_PREFIX/etc/profile.d" etc/lf.csh etc/lfcd.csh
	# fish integration
	install -Dm644 -t "$MCHS_PREFIX/share/fish/vendor_functions.d" etc/lfcd.fish
	install -Dm644 -t "$MCHS_PREFIX/share/fish/vendor_completions.d" etc/lf.fish
	# vim integration
	install -Dm644 -t "$MCHS_PREFIX/share/vim/vimfiles/plugin" etc/lf.vim
	# zsh integration
	install -Dm644 -T etc/lfcd.sh "$MCHS_PREFIX/share/zsh/site-functions/lfcd"
	install -Dm644 -T etc/lf.zsh "$MCHS_PREFIX/share/zsh/site-functions/_lf"
}
