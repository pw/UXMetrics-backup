#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean 
if [ $PREVIEW_BUILD = 'true' ]
then
  bundle exec rails db:schema:load  
fi
bundle exec rails db:migrate