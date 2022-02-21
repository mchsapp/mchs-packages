MCHS_PKG_HOMEPAGE=https://ocaml.org
MCHS_PKG_DESCRIPTION="Programming language supporting functional, imperative and object-oriented styles"
MCHS_PKG_VERSION=4.02.3
MCHS_PKG_SRCURL=http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-4.02.3.tar.xz
MCHS_PKG_DEPENDS="pcre, openssl, libuuid"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	./configure -prefix $MCHS_PREFIX -mandir $MCHS_PREFIX/share/man/man1 -cc "$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		-host $MCHS_HOST_PLATFORM
}
