#!/bin/bash
#
set -o nounset
set -o errexit

# Ensure superuser privileges, if required
[[ $EUID -ne 0 ]] && {
	printf '%s\n' 'Must be run as superuser' >&2
	exit 1
}

rm -vf /usr/local/bin/linux-purge
rm -vf /usr/local/bin/update-linux-purge

rm -vf /etc/bash_completion.d/linux-purge
rm -vf /usr/share/bash-completion/completions/linux-purge
rm -vf /usr/local/share/bash-completion/completions/linux-purge
rm -vf /usr/local/share/bash-completion/completions/linux-purge.bash

rm -vf /usr/local/man/man8/linux-purge.8
rm -vf /usr/local/man/man8/linux-purge.8.gz
mandb -q
