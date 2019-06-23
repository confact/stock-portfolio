# README

This is a simple Stock portfolio performance check - made just for fun

## Requirements
No need for database or anything, just ruby and ruby on rails.

## Install

1. Install rvm/ruby 2.5.3
2. run  `bundle install` - not working? install bundler first with `gem install bundler`
3. run `rails s -b 0.0.0.0`
4. go to http://localhost:3000

### Vagrant

1. run `vagrant up`
2. run `vagrant ssh`
3. go to `/vagrant`
4. run `rails s -b 0.0.0.0`
5. go to http://localhost:3100

## ENV Variables
you would need to set a env variable for the api for https://www.worldtradingdata.com.
either add a .env file to root (where you find this file) or `/vagrant`

the .env file should contain `WORLDTRADINGDATA_TOKEN=thetoken`

You can also add the env before `rails s...` , I hope you know how that is done. :)

the ENV key is `WORLDTRADINGDATA_TOKEN`

## Tests

Some tests are there to check the core stuff like calculation of start and end budgets which the rest calculation is based on.

To run them, just do `rspec` in root or in `/vagrant` if you use the vagrant.

## Good to know

1. Limited to 3 stocks/allocations - it is built to be flexible but didn't have time to build a `add more allocation/stock`-functionality yet. Maybe soon.
