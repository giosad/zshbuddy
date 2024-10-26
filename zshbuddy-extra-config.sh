# Configuration of extra aliases for shell commands

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

# Common aliases
# enable in ls:
# - file types highlighting
# - sort directories first
# - human readable sizes
# - colors
alias ls="$LS -Fh --color=auto --group-directories-first"
alias ll='ls -l'
alias la='ls -la'
alias grep='grep --color=auto'
alias fd="$FD --color=never"

# Python's virtual environment aliases

# Function to find and source the closest .venv directory
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
alias vd='deactivate'
