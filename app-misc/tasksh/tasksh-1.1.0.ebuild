# Copyright 2017 Johannes Rosenberger
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils cmake-utils

DESCRIPTION="A command-line front-end for Taskwarrior (app-misc/task)."
HOMEPAGE="http://taskwarrior.org/"
SRC_URI="http://taskwarrior.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/readline:0
	elibc_glibc? ( sys-apps/util-linux )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DTASKSH_DOCDIR=share/doc/${PF}
	)
	cmake-utils_src_configure
}
