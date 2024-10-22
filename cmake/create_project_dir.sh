#! /bin/bash

proj_name="$1"
if [ -z "$proj_name" ]; then
	proj_name="proj_template"
fi

if [ -d "$proj_name" ]; then
	echo "directory $proj_name already exists!"
	exit 1
fi

mkdir "$proj_name"
cd "$proj_name"

mkdir cmake
mkdir lib
mkdir source
mkdir vendor

git init
touch .gitignore