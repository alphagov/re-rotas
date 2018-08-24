#!/usr/bin/env bash

set -eu

export RAILS_ENV=development
export DB_USER=postgres

command -v docker > /dev/null || (echo "docker not installed" && exit 1)
command -v npm > /dev/null || (echo "npm not installed" && exit 1)

DB_CONTAINER_NAME="who-is-on-call-dev-postgres"

docker run --name $DB_CONTAINER_NAME --rm -p 5432:5432 postgres >log/postgres.log 2>&1 &

function notsuccess {
    docker stop $DB_CONTAINER_NAME
}
trap notsuccess EXIT

bundle check || bundle install
npm install

bin/rake db:create db:migrate
DISABLE_AUTH=yes bin/rails s
