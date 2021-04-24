build_constants() {
  local src="$1"
  local dest="$2"

  perl -ne 'print if 1 .. /^source/' "${src}" > "${dest}"
  perl -i -ne 'print unless /^SUTILS_|'"${SDIST_INCLUDE_PATTERN}"'/' "${dest}"
  perl -i -pe 's/^source.*//g' "${dest}"
}


build_functions() {
  local src="$1"
  local dest="$2"
  local include_str="$3"
  local include_arr
  local include_re
  local wildcard_re="(^|[[:space:],])[*]($|[[:space:],])"

  if perl -ne '/'"${wildcard_re}"'/ or exit 1' <<< "${includestr}"; then
    include_arr=($(_list_functions))
  else
    IFS=", " read -a include_arr <<< "${includestr}"
  fi

  include_re="(^$(array_join "|^" "${include[@]}"))"

  perl -ne '/'"${include_re}"'/ .. /^}/ and s/^}/$&\n\n/g, print' \
    "${SDIST_UTILS_LIB}" > "${dest}"
}


build_main() {
  local src="$1"
  local dest="$2"

  perl -ne 'print if /^source/ .. eof()' "${src}" > "${dest}"
  perl -i -ne 'print unless 1 .. 3' "${dest}"
}


