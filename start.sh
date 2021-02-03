#!/usr/bin/env bash
set -o errexit

if [ $PREVIEW_BUILD = 'true' ]
then
export FULL_APP_DOMAIN="https://${RAILS_HOST}.onrender.com"
export FULL_APP_DOMAIN_WITHOUT_PROTOCOL="${RAILS_HOST}.onrender.com"
export FULL_APP_DOMAIN_WITHOUT_PROTOCOL_OR_PORT="${RAILS_HOST}.onrender.com"
fi

bundle exec puma -C config/puma.rb




