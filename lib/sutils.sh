out() {
  local IFS=" "
  
  printf "%s\n" "$*"
}


warn() {
  out "WARNING: $@" >&2
}


die() {
  out "ERROR: $@" >&2
  exit 1
}


assert_arg_nonempty() {
  if [[ -z "$2" || "$2" == -* ]]; then
    die "Option '$1' requires a non-empty argument"
  fi
}


confirm() {
  local prompt="$1"

  while true; do
    read -p "${prompt:-Is this OK?} [Y/n] " ok

    case "${ok}" in
      Y|y|"")
        return 0
        ;;
      N|n)
        return 1
        ;;
      *)
        out "Invalid response; please enter 'y' or 'n'"
        ;;
    esac
  done
}


array_join() {
  local delim="$1"
  local str=
  local IFS=
  shift

  str="${*/#/$delim}"

  out "${str:${#delim}}"
}

# vim: set ts=2 sts=2 sw=2 et:
