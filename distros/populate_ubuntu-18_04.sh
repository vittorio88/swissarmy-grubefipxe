#!/bin/sh

DISTRO_FOLDER='ubuntu-18_04'
DISTRO_URL='http://releases.ubuntu.com/18.04/ubuntu-18.04-desktop-amd64.iso'
DISTRO_FILE="${DISTRO_URL##*/}"

DISTRO_SHA256SUMS_URL=http://releases.ubuntu.com/18.04/SHA256SUMS
DISTRO_SHA256SUMS_FILE="${DISTRO_SHA256SUMS_URL##*/}"

# Check if DISTRO_FOLDER EXISTS
if [ -d $DISTRO_FOLDER ]; then
	echo "error: Folder $DISTRO_FOLDER exists, quitting. Please remove it manully to continue."
	exit 1
fi

# Download SHA256SUMS file if it is not present.
if [ ! -f $DISTRO_SHA256SUMS_FILE ]; then
	
	echo "info: Downloading $DISTRO_SHA256SUMS_URL"
	if ! wget $DISTRO_SHA256SUMS_URL; then
		echo "error: Download of $DISTRO_SHA256SUMS_URL failed."
		exit 1
	fi
fi

# If file exists, check the SHA256. If it doesn't download it.
if [ -f $DISTRO_FILE ]; then
	echo "Checking SHA256 of file $DISTRO_FILE"
	if ! sha256sum -c SHA256SUMS | grep 'ubuntu-18.04-desktop-amd64.iso' | grep OK ; then
		echo "Checksum of existing file: $DISTRO_FILE failed. Please remove it or it's accompanying SHA256SUMS file manually, and try again."
		exit 1
	fi

else
	echo "Downloading $DISTRO_URL"
	if ! wget $DISTRO_URL; then
		echo "error: Download of $DISTRO_URL failed."
		exit 1
	fi
fi


# Extract DISTRO_FILE
echo "Extracting $DISTRO_FILE"
if ! 7z x -y $DISTRO_FILE -o$DISTRO_FOLDER ; then
	echo "error: extraction of $DISTRO_FILE failed."
	exit 1
fi

echo "Populating of: $DISTRO_FOLDER completed. You can now rm $DISTRO_FILE to save storage space."

