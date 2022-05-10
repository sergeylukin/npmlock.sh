#!/bin/bash

## npmlock version
VERSION="0.1.0"

## output usage
usage () {
  echo "usage: npmlock [-hV] <package>"
}

## main
npmlock () {
  local found paths seen
  declare -a paths=()
  declare -a seen=()
  declare -a found=()
  local package="$1"

  case "$package" in
    -h|--help)
      usage
      return 0
      ;;

    -v|--version)
      echo "$VERSION"
      return 0
      ;;

    *)
      if [ "-" = "${package:0:1}" ]; then
        echo >&2 "error: Unknown argument \`$package'"
        return 1
      fi
      ;;
  esac

  ## business logic

  ## get total
  count="${#found[@]}"

  if (( count == 1 )); then
    echo "${found[0]}"
  elif (( count > 0 )); then
    printf "npmlock: found %d result(s)\n" "$count"
  else
    echo "npmlock: Couldn't find anything that matches \`$package'"
    return 1
  fi
  return 0
}

## export or run
if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
  export -f npmlock
else
  npmlock "$@"
fi
