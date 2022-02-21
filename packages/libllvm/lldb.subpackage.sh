MCHS_SUBPKG_INCLUDE="
bin/lldb*
include/lldb/
lib/liblldb.so
"
MCHS_SUBPKG_DESCRIPTION="LLVM-based debugger"
MCHS_SUBPKG_DEPENDS="libc++, libedit, libxml2, ncurses-ui-libs"
MCHS_SUBPKG_BREAKS="lldb-dev, lldb-static"
MCHS_SUBPKG_REPLACES="lldb-dev, lldb-static"
