#!/bin/bash -ue

# This script is for maintainer uses. It may have non-portable features.
# If you need to change something to make it work on your platform, please
# send us a patch, we'll take it in consideration.

# By the way, this is a quick and dirty script ;)

project_name=RedBoxApp

export script_dir="$(dirname "${BASH_SOURCE[0]}")"
declare -r script_dir

function print_help() {
	local this="${0}"
	cat <<END_OF_HELP
Usage:
	$this [version]

This script automates some parts of releasing this software.

It relies on mercurial being available.

If no version is passed, stable is assumed. You can pass
anything that can be passed to --rev to mercurial there.

END_OF_HELP
}

if [[ $# -gt 0 ]]; then
	if [ $# -gt 1 -o "$1" == "--help" -o "$1" == "-h" ]; then
		print_help
		exit 0
	fi
	version="$1"
	print_version="$1"
else
	version="stable"
fi
HG=${HG-hg}
declare -r HG

# Checking if mercurial is available
if ! which $HG > /dev/null; then
	echo 'Mercurial is not available as `'$HG'`.' >&2;
	exit 1
fi

# Special case for the tag stable
if [[ $version == "stable" ]]; then
	#version=$($HG -R "$script_dir/../" parent --rev $version --template "{latesttag}-dev+{latesttagdistance}\n")
	print_version=$($HG -R "$script_dir/../" id --rev $version)
	print_version=$(echo $print_version | cut -d'/' -f2)
fi

if [[ $print_version =~ v[[:digit:]].* ]]; then
	print_version=${print_version#v}
fi

echo Version $version is released as $print_version;

echo Copying from repo

$HG -R "$script_dir/../" archive -t files \
	-X $0 --rev $version \
	"${project_name}-${print_version}"

echo Updating version macro

# Dive into the archive folder
pushd "${project_name}-${print_version}"

# This is where we do some magic input the version number
sed -i 'README' -e "s/Development snapshot/${print_version}/"

echo -n "Parsing markdown README..."

out=README.html
f=README
cat > "${out}" <<EOHEADER
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
 
<html lang="fr-ca" xml:lang="fr-ca" xmlns="http://www.w3.org/1999/xhtml"> 
        <head> 
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
                <title>RedBox Application Project - README</title> 
        </head> 
 
        <body> 

EOHEADER

markdown "$f" >> "${out}" || exit 1;

cat >> "${out}" <<EOFOOTER

        </body>
</html>

EOFOOTER

echo " done" # Parsing Markdown readme done

# Get out of the archive folder
popd

echo Archiving

tar cjf "${project_name}-${print_version}-src.tar.bz2" "${project_name}-${print_version}"

echo Done.

ls -l "${project_name}-${print_version}-src.tar.bz2"
