#!/usr/bin/env bash

set -eu

export RAILS_ENV=test
export DB_USER=postgres

function notsuccess {
    echo "pre-commit fail!"
}
trap notsuccess ERR

command -v docker > /dev/null || (echo "docker not installed" && exit 1)

DB_CONTAINER_NAME="who-is-on-call-pre-commit-postgres"

function notsuccess {
    docker stop $DB_CONTAINER_NAME >/dev/null 2>&1 || echo -n ''
}
trap notsuccess EXIT

notsuccess
docker run --name $DB_CONTAINER_NAME --rm -p 5432:5432 postgres >log/postgres.log 2>&1 &


bundle check || bundle install
npm install

bin/rake db:create db:migrate

bundle exec rake

command -v shellcheck >/dev/null 2>&1 && shellcheck ./*.sh || echo "no shellcheck install, skipping test"

echo "pre-commit success!"

