MCHS_PKG_HOMEPAGE=https://hunspell.github.io
MCHS_PKG_DESCRIPTION="American english dictionary for hunspell"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20210101
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/en/en_US.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/en/en_US.dic
	# In which case we need to bump version and checksum used.
	mchs_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.aff \
			$MCHS_PREFIX/share/hunspell/en_US.aff \
			c7a8c4d08c29d237880844b1623099f59092602f189be38ce3912e457ff38bc1
	mchs_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.dic \
			$MCHS_PREFIX/share/hunspell/en_US.dic \
		        f0b1a234bd178bdd01875b2a392a9647f888b8fe879f79c52aae62c2759b3647
	touch $MCHS_PREFIX/share/hunspell/en_US.{aff,dic}
}
