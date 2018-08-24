#!/usr/bin/env bash

set -eu

export RAILS_ENV=test
export DB_USER=postgres

function precommit_fail {
    echo "pre-commit fail!"
}
trap precommit_fail ERR

command -v docker > /dev/null || (echo "docker not installed" && exit 1)

DB_CONTAINER_NAME="who-is-on-call-pre-commit-postgres"

function stop_database {
    docker stop $DB_CONTAINER_NAME >/dev/null 2>&1 || echo -n ''
}
trap stop_database EXIT

stop_database
docker run --name $DB_CONTAINER_NAME --rm -p 5432:5432 postgres >log/postgres.log 2>&1 &

bundle check || bundle install
npm install

bin/rake db:create db:migrate

bundle exec rake

if command -v shellcheck >/dev/null 2>&1; then
 shellcheck ./*.sh
else
 echo "no shellcheck install, skipping test"
fi

echo "pre-commit success!"

