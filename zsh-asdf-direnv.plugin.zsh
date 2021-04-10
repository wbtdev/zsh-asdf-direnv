# Copyright (c) 2021 Brad Thorne
# ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
# ASDF_COMPLETIONS="$ASDF_DIR/completions"

0=${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}
0=${${(M)0:#/*}:-$PWD/$0}

# Then ${0:h} to get plugin's directory

# if [[ ${zsh_loaded_plugins[-1]} != */zsh-asdf-direnv && -z ${fpath[(r)${0:h}]} ]] {
#     fpath+=( "${0:h}" )
# }

typeset -gA Plugins
Plugins[ZSH_ASDF_DIRENV_DIR]="${0:h}"

# # Load command
# [ -f "$ASDF_DIR/asdf.sh" ] && {
#   . "$ASDF_DIR/asdf.sh";
#   # [ -d "$ASDF_COMPLETIONS" ] && fpath+=("$ASDF_COMPLETIONS")
# }

[[ -n ${commands[direnv]} ]] || return

_direnv_hook() {
  trap -- '' SIGINT;
  eval "$(${commands[direnv]} export zsh)";
  trap - SIGINT;
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions=( _direnv_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z ${chpwd_functions[(r)_direnv_hook]} ]]; then
  chpwd_functions=( _direnv_hook ${chpwd_functions[@]} )
fi
