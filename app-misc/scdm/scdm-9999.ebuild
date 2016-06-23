# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils

if [[ ${PV} != 9999* ]]; then
	COMMIT=""
	SRC_URI="https://github.com/jorsn/scdm/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~x86"
else
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="git://github.com/jorsn/scdm.git
		https://github.com/jorsn/scdm.git"
fi

DESCRIPTION="The Simple Console Display Manager"
HOMEPAGE="https://github.com/jorsn/scdm/"

LICENSE="BSD"
SLOT="0"

src_prepare() {
	mv "${S}/profile.sh" "${S}/${PN}.sh"
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"

	insinto /etc
	doins "${PN}rc"
	insinto /etc/profile.d/
	doins "${PN}.sh"

	dodoc LICENSE
	dodoc README.md

	doman "${PN}.1"
}

pkg_postinst() {
	einfo "In order to use SCDM you must first edit your /etc/scdmrc or"
	einfo "\$HOME/.scdmrc to specify the sessions you want to use."
	einfo "Then just login with your username."
	ewarn "Remove xdm from default runlevel!"
}
