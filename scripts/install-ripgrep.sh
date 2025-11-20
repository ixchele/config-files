#!/bin/zsh
# This script installs Ripgrep on Linux x64

# Custom variables
dest="$HOME/goinfre/Apps/rg"
tmpfile="/tmp/rg"
url="https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz"
bin_dir="$HOME/.local/bin"

echo "Download the 14.1.1 version of ripgrep for Linux x64..."
wget -O $tmpfile $url 2>/dev/null

# Extract the tarball
echo "Extracting the package..."
mkdir -p $dest
tar -xzf $tmpfile -C /tmp
cp -r /tmp/ripgrep-14.1.1-x86_64-unknown-linux-musl/* $dest

# Create a symbolic link to the binary
echo "Creating a symbolic link to the binary..."
mkdir -p $bin_dir
ln -sf $dest/rg $bin_dir/rg

# Clean up
echo "Cleaning up..."
rm -f $tmpfile
rm -rf /tmp/ripgrep-14.1.1-x86_64-unknown-linux-musl 

echo "ripgrep has been successfully installed!"
./$bin_dir/rg --version
