#!/usr/bin/env bash
set -eu

export RAILS_ENV='test'
export DB_USER='postgres'

function precommit_fail {
    echo '‼️   pre-commit fail'
}
trap precommit_fail ERR

bundle check || bundle install
npm install

echo '🕵️   checking your horrible code'
rake db:create db:schema:load
rake

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck ./*.sh
else
  echo "‼️    no shellcheck install, skipping test"
fi

echo '✅   pre-commit success!'
