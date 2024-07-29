#!/usr/bin/env bash


GIT_REMOTE=$(git remote get-url origin)
CURRENT_BRANCH=
# Get tracked remote branch associated to current branch (default to main)
{
    git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null &&
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref --symbolic-full-name HEAD 2>/dev/null)
} || {
    CURRENT_BRANCH="main"
}

cat <<EOF > $XDG_CONFIG_HOME/nf-scil/.env
# This file is used to store environment variables for the project.
# It is sourced by the shell on startup of every terminals.

export PROFILE=docker
export NFCORE_MODULES_GIT_REMOTE=$GIT_REMOTE
export NFCORE_MODULES_BRANCH=$CURRENT_BRANCH
export NFCORE_SUBWORKFLOWS_GIT_REMOTE=$GIT_REMOTE
export NFCORE_SUBWORKFLOWS_BRANCH=$CURRENT_BRANCH
EOF

poetry install --no-root
