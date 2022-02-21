MCHS_PKG_HOMEPAGE=https://apr.apache.org/
MCHS_PKG_DESCRIPTION="Apache Portable Runtime Library"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.0
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://dlcdn.apache.org/apr/apr-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=e2e148f0b2e99b8e5c6caa09f6d4fb4dd3e83f744aa72a952f94f5a14436f7ea
MCHS_PKG_DEPENDS="libuuid"
MCHS_PKG_BREAKS="apr-dev"
MCHS_PKG_REPLACES="apr-dev"
MCHS_PKG_BUILD_IN_SRC=true
# "ac_cv_search_crypt=" to avoid needlessly linking to libcrypt.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-installbuilddir=$MCHS_PREFIX/share/apr-1/build
ac_cv_func_getrandom=no
ac_cv_have_decl_SYS_getrandom=no
ap_cv_atomic_builtins=yes
apr_cv_mutex_recursive=yes
apr_cv_epoll=yes
apr_cv_epoll_create1=yes
apr_cv_dup3=yes
apr_cv_accept4=yes
apr_cv_sock_cloexec=yes
ac_cv_file__dev_zero=yes
ac_cv_strerror_r_rc_int=yes
ac_cv_func_setpgrp_void=yes
ac_cv_struct_rlimit=yes
ac_cv_func_sem_open=no
apr_cv_process_shared_works=yes
apr_cv_mutex_robust_shared=no
ac_cv_o_nonblock_inherited=no
apr_cv_tcp_nodelay_with_cork=yes
apr_cv_gai_addrconfig=yes
ac_cv_sizeof_pid_t=4
ac_cv_sizeof_ssize_t=$(( MCHS_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_size_t=$(( MCHS_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_off_t=$(( MCHS_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_struct_iovec=$(( MCHS_ARCH_BITS==32 ? 8 : 16 ))
ac_cv_search_crypt="
MCHS_PKG_RM_AFTER_INSTALL="lib/apr.exp"
