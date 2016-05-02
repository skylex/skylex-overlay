# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiofilter/audiofilter-9999.ebuild,v 1.93 2011/10/12 22:53:27 vapier Exp $

EAPI="2"

inherit eutils python git-2 autotools

EGIT_REPO_URI="git://github.com/cbxbiker61/audiofilter.git"

DESCRIPTION="Audiofilter is an ac3filter port for linux"
HOMEPAGE="http://xbmc.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_unpack() {
	git-2_src_unpack
}

src_install() {
	cd gnu
	emake || die
	emake install DESTDIR="${D}" || die
	prepalldocs
}
