# Configration for optimizing zsh experience

# History Settings

# Don't record an entry that matches any previous entries
setopt HIST_IGNORE_DUPS

# Do not display duplicate entries when searching
setopt HIST_FIND_NO_DUPS

# Remove extra blanks from each command line being added to the history list
setopt HIST_REDUCE_BLANKS

# Save timestamps in the history file
setopt EXTENDED_HISTORY

# Append commands to the history instead of replacing
setopt APPEND_HISTORY

# Don't record an entry that starts with a space
setopt HIST_IGNORE_SPACE

# Verify history expansions before executing
setopt HIST_VERIFY

# Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST 

# Set the maximum number of history entries saved in the history file
HISTFILESIZE=10000

# Set the maximum number of history entries stored in memory
HISTSIZE=3000

# Directory Stack Options

# Change to a directory just by typing its name
setopt AUTO_CD

# Automatically push the old directory onto the directory stack when changing directories
setopt AUTO_PUSHD

# Don't record duplicate directories in the directory stack
setopt PUSHD_IGNORE_DUPS

# Don't print the directory stack when pushing directories
setopt PUSHD_SILENT

# Change to the home directory when 'cd' is typed without an argument
setopt PUSHD_TO_HOME


# Bind arrow up and down keys for history substring search plugin from zsh-plugins.txt
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
