#!/bin/bash

sudo locale-gen en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y nodejs software-properties-common build-essential git libpq-dev curl

sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
sudo apt-key add -
sudo add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main'
sudo apt-get update

sudo apt-get install -y postgresql-9.6

# postgresql
sudo -u postgres psql postgres -c "create user codelitt with password 'codelitt';"
sudo -u postgres psql postgres -c "alter user codelitt with superuser;"
sudo -u postgres psql postgres -c 'alter user codelitt with createdb;'

#rvm
su - vagrant -c 'command curl -sSL https://rvm.io/mpapis.asc | gpg --import -'
su - vagrant -c 'command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -'
su - vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable'
su - vagrant -c 'rvm install 2.5.3 --default'
su - vagrant -c 'rvm install 2.5.3 --default'
su - vagrant -c 'gem install bundler'
su - vagrant -c 'bundle config github.https true'
su - vagrant -c 'cd /vagrant && bundle install'
