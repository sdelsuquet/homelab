#!/usr/bin/env sh
# script verify with shellcheck 

# https://unix.stackexchange.com/questions/285924/how-to-compare-a-programs-version-in-a-shell-script

funct_version_compare () {
  funct_sub_ver () {
    # local len=${#1}
    temp=${1%%"."*} && indexOf=$(echo ${1%%"."*} | echo ${#temp})
    echo "${1:0:indexOf}"
  }
  funct_cut_dot () {
    offset=${#1}
    length=${#2}
    echo "${2:((++offset)):length}"
  }
  if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "=" && exit 0
  fi
  v1="$(echo ${1} | tr -d ':space:')"
  v2="$(echo ${2} | tr -d ':space:')"
  v1_sub="$(funct_sub_ver ${v1})"
  v2_sub="$(funct_sub_ver ${v2})"
  if [ "${v1_sub}" > "${v2_sub}" ]; then
    echo ">"
  elif [ "${v1_sub}" < "${v2_sub}" ]; then
    echo "<"
  else
    funct_version_compare "$(funct_cut_dot "${v1}_sub" "${v1}")" "$(funct_cut_dot "${v2}_sub" "${v2}")"
  fi
}
