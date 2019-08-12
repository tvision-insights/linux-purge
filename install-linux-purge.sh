#!/bin/bash
#
set -o nounset
set -o errexit

# Ensure superuser privileges, if required
[[ $EUID -ne 0 ]] && {
	printf '%s\n' 'Must be run as superuser' >&2
	exit 1
}

# install the executable
cd /usr/local/bin/
wget -N https://git.launchpad.net/linux-purge/plain/usr/bin/linux-purge
chmod +x linux-purge

# install manual page
mandir=/usr/local/man/man8
mkdir -p "$mandir"
cd "$mandir"
wget -N https://git.launchpad.net/linux-purge/plain/debian/linux-purge.8
mandb -q

# install Bash completion
# use output of `pkg-config --variable=completionsdir bash-completion` 
# for completions directory, if possible
compdir=/usr/share/bash-completion/completions 
# else use output of `pkg-config --variable=compatdir bash-completion`
[[ -d $compdir ]] || compdir=/etc/bash_completion.d
cd "$compdir"
wget -N https://git.launchpad.net/linux-purge/plain/debian/linux-purge.bash-completion
mv -f linux-purge.bash-completion linux-purge

