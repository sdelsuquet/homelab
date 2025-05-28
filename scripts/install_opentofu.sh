#!/usr/bin/env bash

###############################################################
#  TITRE:
#
#  AUTEUR:   Stéphane
#  VERSION:
#  CREATION:  06:47:11 14/03/2021
#  MODIFIE:
#
#  DESCRIPTION:
###############################################################
# set -x +n
# set -v


# BASENAME="$(basename """$(readlink -nf """$0""")""")";
# NAMENOEXT="${BASENAME%%.*}";
# SCRIPT_PATH="${BASH_SOURCE[0]}";

PROJECT_ROOT="$(git rev-parse --show-toplevel)";

. "$PROJECT_ROOT/scripts/lib_functions.sh"

version="1.8.9"


if [[ ! PATH_COMMAND = "$(type -p "tofu")" ]] || [[ -z ${PATH_COMMAND} ]]; then
    version_installed=$($(which tofu) -version | head -n1 | awk -F' ' '{print $2}' | tail -c+2)
    echo "opentoufu est déjà installé avec la version ${version_installed}"

    last_version="$(curl --silent https://api.github.com/repos/opentofu/opentofu/tags | grep name | awk -F':' '{print $2}' | awk '{print substr($0,3,length($0)-4)}' | grep -v -E 'alpha|beta|rc' | head -n1 | tail -c+2)"

    echo "La dernière version est : ${last_version}"

    if [[ $(funct_version_compare "${last_version}" "${version}") == ">" ]]; then
        echo "une version plus récente de opentofu a ét é publiée."
    fi

fi

archive="tofu_${version}_linux_amd64.tar.gz"

wget --quiet --show-progress "https://github.com/opentofu/opentofu/releases/download/v${version}/${archive}" --output-document="/tmp/${archive}"

tar -xvzf "/tmp/${archive}" --one-top-level=/tmp/tofu

sudo install --preserve-timestamps /tmp/tofu/tofu --target-directory=/usr/local/bin/

# Shell Tab-completion
# https://opentofu.org/docs/cli/commands/#shell-tab-completion
LINE='complete -C /usr/local/bin/tofu tofu'
FILE="${HOME}/.bashrc"
#grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
grep -qF -- "${LINE}" "${FILE}"
if $? -eq 0 ; then
    tofu -install-autocomplete
    source ${FILE}
fi



# sudo mv --verbose terraform /usr/local/bin/
# sudo chown --verbose root:root /usr/local/bin/terraform
# rm --verbose "${archive}"
# terraform version
# terraform -help
# terraform -install-autocomplete
