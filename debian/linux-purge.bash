_linux-purge()
{
	local IFS=$'\n' # needed for handling trailing space of some options and all arguments
	local cur prev words cword split # needed by _init_completion()
	local opts args opt i prefix= wordlist
	local -A args
	# Do not treat = as word breaks even if they are in $COMP_WORDBREAKS:
	# Split option=value into option in $prev and value in $cur
	_init_completion -s || return

	# DEFINE OPTIONS THAT DO NOT TAKE AN ARGUMENT HERE:
	opts=(auto-only clear-boot choose fix help info manual no-legend \
optimize simulate version yes debug)
	# DEFINE THE OPTIONS WITH ARGUMENTS HERE:
	args=([debug]= [interface]=$'dialog\nwhiptail' [keep]=$(seq 0 9))

	for i in ${!args[*]}; do
		if [[ $prev = --$i ]]; then
			local j dobreak=
			[[ $split == false ]] && {
				# equal sign not used; check, if argument is optional.
				for j in ${opts[*]}; do [[ $i == $j ]] && { dobreak=t; break; } done
			}
			[[ $dobreak ]] && break

			[[ "$COMP_WORDBREAKS" != *=* && $split == true ]] && prefix="--$i="
			if [[ ${args[$i]} ]]; then
				COMPREPLY=( $( compgen -P "$prefix" -W "${args[$i]}" -- "$cur" ) )
			else
				case $i in
					debug)
						COMPREPLY=( $( compgen -P "$prefix" -A file -- "$cur" ) )
						compopt -o filenames ;;
				esac
			fi
			return 0
		fi
	done

	wordlist=()
	for i in ${opts[*]}; do wordlist+=("--$i "); done
	for i in ${!args[*]}; do wordlist+=("--$i="); done
	COMPREPLY=( $( compgen -W "${wordlist[*]}" -- "$cur" ) )
	compopt -o nospace
} && complete -F _linux-purge linux-purge


