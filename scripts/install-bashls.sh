#!/bin/bash
# This script installs Bash Language Server (bashls) manually on Linux x64

# Custom variables
dest="$HOME/goinfre/Apps/bashls"
tmpdir="/tmp/bashls"
bin_dir="$HOME/.local/bin"
url="https://registry.npmjs.org/bash-language-server/-/bash-language-server-5.3.2.tgz"

echo "Downloading bash-language-server..."
mkdir -p $tmpdir
wget -O "$tmpdir/bashls.tgz" "$url" 2>/dev/null

echo "Extracting the package..."
mkdir -p $dest
tar -xzf "$tmpdir/bashls.tgz" -C $tmpdir

# Move the extracted files to the destination folder
cp -r $tmpdir/package/* $dest/

# Create a small wrapper script to launch bashls via Node.js
echo "Creating executable wrapper..."
mkdir -p $bin_dir
cat <<EOF > "$bin_dir/bash-language-server"
#!/bin/sh
node "$dest/bin/main.js" "\$@"
EOF
chmod +x "$bin_dir/bash-language-server"

# Clean up
echo "Cleaning up..."
rm -rf "$tmpdir"

echo "bash-language-server has been successfully installed!"
echo "Make sure Node.js is installed and in your PATH."
echo ""
echo "✅ Binary location: $bin_dir/bash-language-server"
echo "✅ You can now use it in Neovim LSP config as 'bashls'"

