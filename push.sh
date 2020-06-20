#!/bin/bash -e
nr_of_commits=$(git rev-list --count master)
id_of_latest_commit=$(git rev-parse --short master)
# Note that full id of N'th commit is
# git log --skip=$((nr_of_commits - N)) --max-count=1 --pretty=format:%H
version=1.0.${nr_of_commits}-${id_of_latest_commit}
logfile=$(mktemp)
trap 'rm $logfile' EXIT
sed -E -i.bak  's/(^program_version=)[[:digit:]]+\.[[:digit:]]+.* \\/\1'\
$version' \\/w '$logfile ./linux-purge
[[ -s $logfile ]] || { echo 'Error: did not find version' >&2; exit 1; }
./make-man.sh
git commit -am "Update version to $version"
git push origin master

