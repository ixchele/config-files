#!/bin/bash

file=".clangd"

cat > $file << EOF
CompileFlags:
  Add: [
    -I., 
	-I./include,
    -Wall,
    -Wextra,
    -Werror,
    -std=c++98,
  ]
EOF
