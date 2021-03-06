#!/bin/sh
export LC_ALL=C
# tuned for GNU help2man 1.47.15
help2man -s 8 -N -n 'purge obsolete kernels in Ubuntu' ./linux-purge \
| sed -r '
s/(\.\\" DO NOT MODIFY THIS FILE!  It was generated by)./\1 make-man.sh script of linux-purge repository using /
s/<http/\\%&/g  # do not hyphenate web addressess
s/^Copyright.*/&\n.br/ # keep line break after copyright line
/^\.SH SYNOPSIS/,/^\.SH/ {
	/^\./b  # do not modify lines starting with dot
	s#\\fI\\,##g  # remove tags
	s#\\/\\fR##g  # remove tags
	s#([^[:alpha:]-])([[:upper:]]+)#\1\\fI\\,\2\\/\\fR#g  # underline arguments
	s#--?[[:alpha:]]+#\\fB\\&\\/\\fR#g  # make options bold
}'  >./doc/linux-purge.8
