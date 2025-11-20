#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# create-makefile
# Generate a C++ Makefile
# ============================================================

# --- Default values ---
NAME="a.out"
CXX="c++"
CPPFLAGS="-Wall -Wextra -Werror -std=c++98"
INCLUDES="-I."
LFLAGS=""
SRC="*.cpp"

# --- Parse arguments ---
for arg in "$@"; do
    case $arg in
        name=*) NAME="${arg#*=}" ;;
        CXX=*) CXX="${arg#*=}" ;;
        CPPFLAGS=*) CPPFLAGS="${arg#*=}" ;;
        INCLUDES=*) INCLUDES="${arg#*=}" ;;
        LFLAGS=*) LFLAGS="${arg#*=}" ;;
        SRC=*) SRC="${arg#*=}" ;;
        *) echo "Invalid argument: $arg" ;;
    esac
done

# --- Expand SRC ---
SRC_EXPANDED=$(printf "%s " $SRC 2>/dev/null || echo "$SRC")

# --- Build the Makefile ---
cat > Makefile <<EOF
# --- Colors ---
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BOLD = \033[1m
RESET = \033[0m
CLEAR = \033[2K\r

# --- Variables ---
NAME = $NAME
CXX = $CXX
CPPFLAGS = $CPPFLAGS
INCLUDES = $INCLUDES
LFLAGS = $LFLAGS
SRC = $SRC_EXPANDED
OBJ = \$(SRC:%.cpp=obj/%.o)

all: \$(NAME)
	@printf "\$(GREEN)\$(BOLD)\$(NAME) done!\$(RESET)\n"

\$(NAME): \$(OBJ)
	@printf "\$(CLEAR)\$(YELLOW)linking \$(NAME)...\$(RESET)\n"
	@\$(CXX) \$(OBJ) \$(LFLAGS) -o \$(NAME)

obj/%.o: %.cpp
	@mkdir -p \$(dir \$@)
	@printf "[\$(GREEN)\$(BOLD) OK \$(RESET)\$(BOLD)]\$(RESET) compiling \$(BOLD)\$@...\$(RESET)\$(CLEAR)"
	@\$(CXX) -c \$(CPPFLAGS) \$< \$(INCLUDES) -o \$@

clean:
	@printf "\$(RED)\$(BOLD)cleaning object files...\n"
	@rm -rf obj/

fclean: clean
	@printf "\$(RED)\$(BOLD)cleaning all...\n"
	@rm -f \$(NAME)

re: fclean all

.PHONY: all clean fclean re
EOF

echo "Makefile generated for '$NAME'"
