# Configuration of extra aliases for shell commands

# Unifies command names for macOS and linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    LS='gls'
    FD='fd'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    LS='ls'
    FD='fdfind'
else
    echo "Unsupported operating system: $OSTYPE"
    return 1
fi

# enable in ls:
#   - file types highlighting
#   - sort directories first
#   - human readable sizes
#   - colors
alias ls="$LS -Fh --color=auto --group-directories-first"
alias ll='ls -l'
alias la='ls -la'

# disable color in fd since it messes with macOS terminal colors
alias fd="$FD --color=never"

# Python's virtual environment aliases
# ------------------------------------

# virtualenv: find and source the closest .venv directory
function va() {
    local dir=$(pwd)
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/.venv/bin/activate" ]]; then
            source "$dir/.venv/bin/activate"
            return
        fi
        dir=$(dirname "$dir")
    done
    echo "No virtual environment found."
}

# virtualenv: deactivate virtual environment
alias vd='deactivate'


# show all zsh shell command completions installed
function compl_list() {
 for command in ${(k)_comps}; do
    completions=${_comps[$command]}
    printf "%-32s %s\n" $command $completions
  done
}
