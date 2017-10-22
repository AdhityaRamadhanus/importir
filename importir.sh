#!/bin/bash

VERSION=0.0.1
REQUIRE_REGEX="require\(['\"]\K([a-zA-Z][^'\"]*)(?=['\"]\))"
IMPORT_REGEX="import\s(.*)\sfrom\s['\"]\K([a-zA-Z][^'\"]*)(?=['\"])"
IGNORED_DIR=(node_modules dist build)

function get_javascript_files {
  local TARGET_DIR="${1:-.}"
  for dir in "${IGNORED_DIR[@]}"; do
    IGNORED_OPTS+=(-not -path "*/${dir}/*")
  done
  # global var
  files=($(find $TARGET_DIR -type f -name '*.js' ${IGNORED_OPTS[@]}))
}

function get_external_dep {
  declare -A GLOBAL_DEPS
  for file in "${files[@]}"; do
    # require
    local local_req_deps=($(grep -oP $REQUIRE_REGEX $file))
    # improt
    local local_import_deps=($(grep -oP $IMPORT_REGEX "$file"))
    if [[ "${#local_req_deps[@]}" -gt 0 ]]; then
      for dependency in "${local_req_deps[@]}"; do
        GLOBAL_DEPS[${dependency}]=1
      done
    fi

    if [[ "${#local_import_deps[@]}" -gt 0 ]]; then
      for dependency in "${local_import_deps[@]}"; do
        GLOBAL_DEPS[${dependency}]=1
      done
    fi

  done

  for dependency in "${!GLOBAL_DEPS[@]}"; do
    echo "$dependency"
  done
}

function main {
  if [[ -z "$1" ]]; then 
    print_usage
    exit 1
  else
    local cmd="${1:-}"; shift
    case "$cmd" in
      list)
        get_javascript_files "$1"
        get_external_dep
      ;;
      version)
        echo "$VERSION"
      ;;
      *)
        print_usage
      ;;
    esac
  fi
}

function print_usage {
cat <<EOF
  NAME:
    importir - bash script to list node.js project dependencies

  USAGE:
    importir command [command options] [arguments...]

  VERSION:
    $VERSION

  AUTHOR:
    Adhitya Ramadhanus <adhitya.ramadhanus@gmail.com>

  COMMANDS:
      list        List all dependencies in target dir (external by default)
      help        See help
      version     See current version
EOF
}

main "$@"
