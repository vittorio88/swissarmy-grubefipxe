#!/bin/sh

DISTRO_FOLDER='ubuntu-16_04'
DISTRO_URL='http://releases.ubuntu.com/16.04/ubuntu-16.04.4-desktop-amd64.iso'
DISTRO_FILE="${DISTRO_URL##*/}"

DISTRO_SHA256SUMS_URL=http://releases.ubuntu.com/16.04/SHA256SUMS
DISTRO_SHA256SUMS_FILE="${DISTRO_SHA256SUMS_URL##*/}"

# Check if DISTRO_FOLDER EXISTS
if [ -d $DISTRO_FOLDER ]; then
	echo "error: Folder $DISTRO_FOLDER exists, quitting. Please remove it manully to continue."
	exit 1
fi

# Check if 7z is available
command -v 7z >/dev/null 2>&1 || { echo >&2 "I require 7z but it's not installed.  Aborting. (on ubuntu: apt install p7zip-full )"; exit 1; }

# Download SHA256SUMS file if it is not present.
if [ ! -f $DISTRO_SHA256SUMS_FILE ]; then

	echo "info: Downloading $DISTRO_SHA256SUMS_URL"
	if ! wget $DISTRO_SHA256SUMS_URL; then
		echo "error: Download of $DISTRO_SHA256SUMS_URL failed."
		exit 1
	fi
fi

# Check if name of iso is present in SHA256SUMS file before downloading and hashing to save time
if ! grep "$DISTRO_FILE" "$DISTRO_SHA256SUMS_FILE";  then
	echo "error: Download of $DISTRO_SHA256SUMS_FILE does not contain $DISTRO_FILE. Please remove $DISTRO_SHA256SUMS_FILE and try again."
	exit 1
fi

# Check if ISO file exists, if not download.
if [ ! -f $DISTRO_FILE ]; then
	echo "Downloading $DISTRO_URL"
	if ! wget $DISTRO_URL; then
		echo "error: Download of $DISTRO_URL failed."
		exit 1
	fi
fi

# Check validity of ISO file
echo "Checking SHA256 of file $DISTRO_FILE"
if ! sha256sum -c SHA256SUMS | grep "$DISTRO_FILE" | grep OK ; then
	echo "Checksum of existing file: $DISTRO_FILE failed. Please remove it or it's accompanying SHA256SUMS file manually, and try again."
	exit 1
fi


# Extract DISTRO_FILE
echo "Extracting $DISTRO_FILE"
if ! 7z x -y $DISTRO_FILE -o$DISTRO_FOLDER ; then
	echo "error: extraction of $DISTRO_FILE failed."
	exit 1
fi

echo "Populating of: $DISTRO_FOLDER completed. You can now rm $DISTRO_FILE to save storage space."

