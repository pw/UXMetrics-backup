#!/usr/bin/env bash

if [ $PREVIEW_BUILD = 'false' ]
then
# exit on error
set -o errexit
fi

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean 
bundle exec rails db:migrate



