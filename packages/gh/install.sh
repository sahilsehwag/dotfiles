#!/usr/bin/env sh
F_pkg_install gh

if F_isInstalled gh; then
	gh extension install coloradocolby/gh-eco
	gh extension install dlvhdr/gh-dash

	gh extension install samcoe/gh-repo-explore

	# TODO:
	gh extension install matt-bartel/gh-clone-org
	gh extension install kawarimidoll/gh-q
	gh extension install rm3l/gh-org-repo-sync
	gh extension install AaronMoat/gh-pulls
	gh extension install meiji163/gh-notify
fi
