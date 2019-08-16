_linux_purge() {
	local cur prev words cword wordlist
	_init_completion || return

	local opts="--auto-only --clear-boot --choose --debug --fix --help \
--info --interface --keep --manual --no-legend --optimize --simulate \
--version --yes"

# Short options are redundant and not that informative; uncomment if you want to
# complete them anyway.
#	opts+='-a -b -c -d -f -h -i -k -m -n -o -s -v -y'

	case $prev in
		-k|--keep)
			[[ $cur =~ ^[0-9]+$ ]] && COMPREPLY=( "$cur" ) || COMPREPLY=( );
			return 0 ;;
	esac
	[[ $prev =~ ^-([^-]*i|-interface)$ ]] && wordlist='dialog whiptail' \
	|| wordlist='$opts'

	COMPREPLY=( $( compgen -W "$wordlist" -- "$cur" ) )
	return 0
} && complete -F _linux_purge linux-purge
