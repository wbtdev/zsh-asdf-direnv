# Copyright (c) 2021 Brad Thorne
[[ -n ${commands[direnv]} ]] || return

typeset -gA Plugins
Plugins[ZSH_ASDF_DIRENV_DIR]="${0:h}"

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
