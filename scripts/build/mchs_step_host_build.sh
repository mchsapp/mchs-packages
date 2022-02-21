mchs_step_host_build() {
	"$MCHS_PKG_SRCDIR/configure" ${MCHS_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j "$MCHS_MAKE_PROCESSES"
}
