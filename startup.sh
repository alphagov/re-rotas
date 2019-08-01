#!/usr/bin/env bash

set -eu

export RAILS_ENV=development

command -v npm > /dev/null || (echo "npm not installed" && exit 1)

bundle check || bundle install
npm install

bin/rake db:create db:schema:load
DISABLE_AUTH=yes bin/rails s
