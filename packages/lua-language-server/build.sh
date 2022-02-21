MCHS_PKG_HOMEPAGE="https://github.com/sumneko/lua-language-server"
MCHS_PKG_DESCRIPTION="Sumneko Lua Language Server coded in Lua"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="MrAdityaAlok <dev.aditya.alok@gmail.com>"
MCHS_PKG_VERSION=2.6.0
MCHS_PKG_REVISION=1
MCHS_PKG_GIT_BRANCH="${MCHS_PKG_VERSION}"
MCHS_PKG_SRCURL="https://github.com/sumneko/lua-language-server.git"
MCHS_PKG_BUILD_DEPENDS="libandroid-spawn"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_BUILD_IN_SRC=true

_patch_on_device() {
	if [ "${MCHS_ON_DEVICE_BUILD}" = true ]; then
		current_dir=$(pwd)

		cd "${MCHS_PKG_SRCDIR}"
		patch --silent -p1 <"${MCHS_PKG_BUILDER_DIR}"/android.diff

		cd "${current_dir}"
	fi
}

mchs_step_host_build() {
	_patch_on_device
	mchs_setup_ninja

	mkdir 3rd
	cp -a "${MCHS_PKG_SRCDIR}"/3rd/luamake 3rd/

	cd 3rd/luamake
	./compile/install.sh
}

mchs_step_make() {
	sed \
		-e "s%\@FLAGS\@%${CFLAGS} ${CPPFLAGS}%g" \
		-e "s%\@LDFLAGS\@%${LDFLAGS}%g" \
		"${MCHS_PKG_BUILDER_DIR}"/make.lua.diff | patch --silent -p1

	"${MCHS_PKG_HOSTBUILD_DIR}"/3rd/luamake/luamake \
		-cc "${CC}" \
		-hostos "android"
}

mchs_step_make_install() {
	local INSTALL_DIR="${MCHS_PREFIX}/lib/${MCHS_PKG_NAME}"

	cat >"${MCHS_PREFIX}/bin/${MCHS_PKG_NAME}" <<-EOF
		#!${MCHS_PREFIX}/bin/bash

		# After action of mchs-elf-cleaner lua-language-server's binary(ELF) is unable to
		# determine its version, so provide it manually.
		if [ "\$1" = "--version" ]; then
			echo "${MCHS_PKG_NAME}: ${MCHS_PKG_VERSION}"
		else
			TMPPATH=\$(mktemp -d "${MCHS_PREFIX}/tmp/${MCHS_PKG_NAME}.XXXX")

			exec ${INSTALL_DIR}/bin/${MCHS_PKG_NAME} \\
				--logpath="\${TMPPATH}/log" \\
				--metapath="\${TMPPATH}/meta" \\
				"\${@}"
		fi

	EOF

	chmod 744 "${MCHS_PREFIX}/bin/${MCHS_PKG_NAME}"

	install -Dm744 -t "${INSTALL_DIR}"/bin ./bin/"${MCHS_PKG_NAME}"
	install -Dm644 -t "${INSTALL_DIR}" ./{main,debugger}.lua
	install -Dm644 -t "${INSTALL_DIR}"/bin ./bin/main.lua

	cp -r ./script ./meta ./locale "${INSTALL_DIR}"
}
