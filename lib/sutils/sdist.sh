build_constants() {
  local src="$1"
  local dest="$2"

  perl -lne 'print if 1 .. /^source/' "${src}" > "${dest}"
  perl -i -lne 'print unless /^SUTILS_|'"${SDIST_INCLUDE_PATTERN}"'/' "${dest}"
  perl -i -lpe 's/^source.*//g' "${dest}"
}


build_functions() {
  local src="$1"
  local dest="$2"
  local includestr="$3"
  local include
  local include_re

  if [[ "${includestr}" == *"*"* ]]; then
    include=($(_list_functions))
  else
    IFS=", " read -a include <<< "${includestr}"
  fi

  include_re="(^$(array_join "|^" "${include[@]}"))"

  perl -lne '/'"${include_re}"'/ .. /^}/ and s/^}/$&\n\n/g, print' \
    "${SDIST_UTILS_LIB}" > "${dest}"
}


build_main() {
  local src="$1"
  local dest="$2"

  perl -lne 'print if /^source/ .. eof()' "${src}" > "${dest}"
  perl -i -lne 'print unless 1 .. 3' "${dest}"
}


