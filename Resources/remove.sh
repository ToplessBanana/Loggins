#!/bin/sh

PACKAGE_FILES=(
	/usr/local/bin/Loggins
)

PACKAGE_ID=(
	com.toplessbanana.pkg.Loggins
)

#

removePackageFiles() {
	
	local package_files=("$@")
	
	for file in "${package_files[@]}"
	do
		/bin/rm -rf $file
	done
}

removePackageFiles "${PACKAGE_FILES[@]}"

#

removePackageID() {
	
	local package_id=("$@")
	
	for id in "${package_id[@]}"
	do
		/usr/sbin/pkgutil --forget $id
	done
}

removePackageID "${PACKAGE_ID[@]}"
