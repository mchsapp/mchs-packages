MCHS_PKG_HOMEPAGE=https://chezmoi.io
MCHS_PKG_DESCRIPTION="Manage your dotfiles across multiple machines"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=2.9.5
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/twpayne/chezmoi/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=10a27e4569c0cd6951a8509a39443f8a918d22d61db0026b78e88ef83fa43e04
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"

	mkdir -p "${MCHS_PKG_BUILDDIR}/src/github.com/twpayne"
	cp -a "${MCHS_PKG_SRCDIR}" "${MCHS_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi"
	cd "${MCHS_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi"

	go get -d -v
	go build -tags noupgrade,noembeddocs \
		-ldflags "-X github.com/twpayne/chezmoi/cmd.DocsDir=$MCHS_PREFIX/share/doc/chezmoi -X main.version=${MCHS_PKG_VERSION}" .
}

mchs_step_make_install() {
	install -Dm700 ${MCHS_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/chezmoi $MCHS_PREFIX/bin/chezmoi

	mkdir -p $MCHS_PREFIX/share/bash-completion/completions \
		$MCHS_PREFIX/share/fish/completions \
		$MCHS_PREFIX/share/zsh/site-functions \
		$MCHS_PREFIX/share/doc/chezmoi

	install -Dm600 ${MCHS_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi-completion.bash \
		$MCHS_PREFIX/share/bash-completion/completions/chezmoi
	install -Dm600 ${MCHS_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi.fish \
		$MCHS_PREFIX/share/fish/vendor_completions.d/chezmoi.fish
	install -Dm600 ${MCHS_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi.zsh \
		$MCHS_PREFIX/share/zsh/site-functions/_chezmoi

	install ${MCHS_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/docs/{FAQ,HOWTO,QUICKSTART,REFERENCE,TEMPLATING}.md \
		$MCHS_PREFIX/share/doc/chezmoi/
}
