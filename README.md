jorsn-gentoo
============

My personal overlay for [gentoo].

Here I place ebuilds that I use but that aren't proposed to or accepted by gentoo
package maintainers. Use at Your own risk – i cannot test ebuilds against all use
flag combinations or architectures.

**DEPRECATION WARNING (2019-05-04): *As I have switched from Gentoo to NixOS, this is no longer maintained, and won't probably be in the near future.***


Installation
-------------

You can either install the overlay via the [repos.conf method][repos.conf] or
use [layman].


### repos.conf

Put a file like this in `/etc/portage/repos.conf/jorsn.conf`:

	[jorsn]
	location = <some-path>/jorsn
	sync-type = git
	sync-uri = https://github.com/jorsn/jorsn-gentoo.git
	auto-sync = yes

Then, sync your portage tree:

	$ emaint sync -r jorsn


### layman

Then, add the overlay to layman and sync:

	$ layman -o https://raw.githubusercontent.com/jorsn/jorsn-gentoo/master/jorsn.xml -f -a jorsn
	$ emaint sync -r jorsn



[gentoo]:       https://gentoo.org
[repos.conf]:   https://wiki.gentoo.org/wiki/Repos.conf
[layman]:       https://wiki.gentoo.org/wiki/Layman


<!-- vim: sw=4 ts=4
-->
