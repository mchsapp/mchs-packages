MCHS_PKG_HOMEPAGE=https://github.com/junegunn/fzf
MCHS_PKG_DESCRIPTION="Command-line fuzzy finder"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.29.0
MCHS_PKG_SRCURL=https://github.com/junegunn/fzf/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a287a8806ce56d764100c5a6551721e16649fd98325f6bf112e96fb09fe3031b
MCHS_PKG_AUTO_UPDATE=true

# Depend on findutils as fzf uses the -fstype option, which busybox
# find does not support, when invoking find:
MCHS_PKG_DEPENDS="bash, findutils"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR

	mkdir -p $GOPATH/src/github.com/junegunn
	mv $MCHS_PKG_SRCDIR $GOPATH/src/github.com/junegunn/fzf
	MCHS_PKG_SRCDIR=$GOPATH/src/github.com/junegunn/fzf

	cd $GOPATH/src/github.com/junegunn/fzf
	go get -d -v github.com/junegunn/fzf
	go build
}

mchs_step_make_install() {
	cd $GOPATH/src/github.com/junegunn/fzf

	install -Dm700 fzf $MCHS_PREFIX/bin/fzf

	# Install fzf-tmux, a bash script for launching fzf in a tmux pane:
	install -Dm700 $MCHS_PKG_SRCDIR/bin/fzf-tmux $MCHS_PREFIX/bin/fzf-tmux

	# Install the fzf.1 man page:
	mkdir -p $MCHS_PREFIX/share/man/man1/
	cp $MCHS_PKG_SRCDIR/man/man1/fzf.1 $MCHS_PREFIX/share/man/man1/

	# Install the rest of the shell scripts:
	mkdir -p $MCHS_PREFIX/share/fzf
	cp $MCHS_PKG_SRCDIR/shell/* $MCHS_PREFIX/share/fzf/
	
	# Symlink shell completions.
	mkdir -p $MCHS_PREFIX/share/bash-completion/completions/
	ln -sfr $MCHS_PREFIX/share/fzf/completion.bash $MCHS_PREFIX/share/bash-completion/completions/fzf
	mkdir -p $MCHS_PREFIX/share/zsh/site-functions
	ln -sfr $MCHS_PREFIX/share/fzf/completion.zsh $MCHS_PREFIX/share/zsh/site-functions/_fzf
	
	# Fish keybindings.
	mkdir -p $MCHS_PREFIX/share/fish/vendor_functions.d
	ln -sfr $MCHS_PREFIX/share/fzf/key-bindings.fish $MCHS_PREFIX/share/fish/vendor_functions.d/fzf_key_bindings.fish

	# Install the nvim plugin:
	mkdir -p $MCHS_PREFIX/share/nvim/runtime/plugin
	cp $MCHS_PKG_SRCDIR/plugin/fzf.vim $MCHS_PREFIX/share/nvim/runtime/plugin/
}
