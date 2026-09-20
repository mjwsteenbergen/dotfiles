# Ubuntu/Debian source a global /etc/zsh/zshrc that runs `compinit` before
# ~/.zshrc is read. That early compinit writes a completion dump without
# zsh-autocomplete's Completions/ directory on $fpath, which leaves its helper
# functions unresolved at runtime:
#   command not found: _autocomplete__should_add_space
#   command not found: _autocomplete__unambiguous
# Skipping it lets ~/.zshrc own completion initialisation.
# See https://github.com/marlonrichert/zsh-autocomplete#installation
skip_global_compinit=1
