# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/luakit/luakit-9999.ebuild,v 1.24 2014/12/11 15:01:11 perfinion Exp $

EAPI=5

#inherit eutils
#inherit toolchain-funcs egit

GH_USER=aidanholm

if [[ ${PV} != 9999* ]]; then
	COMMIT=""
	SRC_URI="https://github.com/${GH_USER:=luakit}/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="git://github.com/${GH_USER:=luakit}/${PN}.git
		https://github.com/${GH_USER}/${PN}.git"
	EGIT_BRANCH="develop"
fi

IUSE="luajit pax_kernel vim-syntax"

DESCRIPTION="fast, small, webkit-gtk based micro-browser extensible by lua"
HOMEPAGE="http://luakit.org"

LICENSE="GPL-3"
SLOT="0/aidanholm"

COMMON_DEPEND="
	luajit? ( dev-lang/luajit:2 )
	!luajit? ( =dev-lang/lua-5.1*:= )
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libunique:1
	net-libs/webkit-gtk:4
	x11-libs/gtk+:3
"

DEPEND="
	virtual/pkgconfig
	pax_kernel? ( sys-apps/elfix )
	${COMMON_DEPEND}
"

RDEPEND="
	${COMMON_DEPEND}
	dev-lua/luafilesystem
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
"

src_prepare() {
	sed -i -e "/^CFLAGS/s/-ggdb//" config.mk || die
	# bug 385471
	use pax_kernel && sed "s,@\$(CC) -o \$@ \$(OBJS) \$(LDFLAGS),@\$(CC) \
		-o \$@ \$(OBJS) \$(LDFLAGS)\n\tpaxmark.sh -m luakit,g" -i Makefile
}

src_compile() {
	myconf="PREFIX=/usr DEVELOPMENT_PATHS=0"
	if use luajit; then
		myconf+=" USE_LUAJIT=1"
	else
		myconf+=" USE_LUAJIT=0"
	fi

	if [[ ${PV} != *9999* ]]; then
		myconf+=" VERSION=${PV}"
	fi

	tc-export CC
	emake ${myconf}
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" install

	if use vim-syntax; then
		local t
		for t in $(ls "${S}"/extras/vim/); do
			insinto /usr/share/vim/vimfiles/"${t}"
			doins "${S}"/extras/vim/"${t}"/luakit.vim
		done
	fi
}
