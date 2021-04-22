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
  local includestr="$3"
  local include
  local include_re

  if perl -ne '/[ \n\t,]+[*][ \n\t,]+/ or exit 1' <<< "${includestr}"; then
    include=($(_list_functions))
  else
    IFS=", " read -a include <<< "${includestr}"
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


