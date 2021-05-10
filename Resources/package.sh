#!/bin/sh

IDENTIFIER=com.toplessbanana.pkg.Loggins
VERSION=1.0
PACKAGE=Loggins.pkg
CERTIFICATE="Developer ID Installer: Jayson Kish (Z375TYY86Z)"
USERNAME="$1"
PROVIDER="Z375TYY86Z"

#

cleanProductDirectory() {
	/usr/bin/find . -name '.DS_Store' -type f -delete
	/usr/bin/xattr -cr
}

cleanProductDirectory

#

createComponentPackage() {
	/usr/bin/pkgbuild --root ./Products ./tmp/$1 --scripts ./Scripts --identifier $2 --version $3
}

createComponentPackage $PACKAGE $IDENTIFIER $VERSION

#

createProductArchive() {
	/usr/bin/productbuild --distribution distribution.plist --package-path ./tmp $1 --sign $2
}

createProductArchive $PACKAGE $CERTIFICATE

#

notarizeProductArchive() {
	/usr/bin/xcrun altool --notarize-app --primary-bundle-id "$1" --username "$2" --password "@keychain:AC_PASSWORD" --asc-provider "$3" --file ./$4
}

notarizeProductArchive $IDENTIFIER $USERNAME $PROVIDER $PACKAGE

#

# Staple the Ticket to Your Distribution
# /usr/bin/xcrun stapler staple $PACKAGE
