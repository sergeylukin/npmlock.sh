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
  declare -a found=("asd")
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
  {
    newjs=$(cat package.json)
    while read -r pkg; read -r version; do
          trimmed_pkg_name=$(echo $pkg | tr -d '"')
          resolved=$(cat package-lock.json | jq --arg pkg "$trimmed_pkg_name" '.dependencies[$pkg].version')
          trimmed_pkg_version=$(echo $resolved | tr -d '"')
          echo "$pkg $version -> $trimmed_pkg_version";
          newjs=$(echo $newjs | jq --arg pkg "$trimmed_pkg_name" --arg version "$trimmed_pkg_version" '.dependencies[$pkg] = $version')
          echo $newjs > /tmp/new.json
          jq '.' /tmp/new.json > /tmp/new2.json
          ## add to found count
          found+=("asd")
        done < <(cat package.json | jq -r '.dependencies | to_entries
                  | map_values(
                  (.value) as $v
                  | { name: .key, version: $v })[] | .name, .version')

        mv /tmp/new2.json package.json
        rm -f /tmp/new.json /tmp/new2.json
      }

  count=${#found[@]}

  if [ $count -eq 1 ]; then
    echo "${found[0]}"
  elif (( $count > 0 )); then
    echo "found $count results"
  elif [[ ! -z "$package" ]]; then
    echo "npmlock: Couldn't find anything that matches '$package'"
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
