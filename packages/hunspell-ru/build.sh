MCHS_PKG_HOMEPAGE=https://hunspell.github.io
MCHS_PKG_DESCRIPTION="Russian dictionary for hunspell"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20210731
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/ru_RU/ru_RU.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/ru_RU/ru_RU.dic
	# In which case we need to bump version and checksum used.
	mchs_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/ru_RU/ru_RU.aff \
			$MCHS_PREFIX/share/hunspell/ru_RU.aff \
			38ce7d4af78e211e9bafe4bf7e3d6a2c420591136cb738ec6648f8fdf6524cd7
	mchs_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/ru_RU/ru_RU.dic \
			$MCHS_PREFIX/share/hunspell/ru_RU.dic \
			f6047416a0204adbecf3a451b874ec8a97ee37e2cbc714466ef04d8dbcc0d6fc
	touch $MCHS_PREFIX/share/hunspell/ru_RU.{aff,dic}
}
