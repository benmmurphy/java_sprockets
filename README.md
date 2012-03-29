Example of using sprockets in a java web application.

#Running

## Install JRuby 1.6.6

- brew install rbenv
- brew install ruby-build
- rbenv install jruby-1.6.6
- export JRUBY_OPTS=--1.9

## Install Bundler
- gem install jruby-openssl
- gem install bundler

## Run
- ./mk_gems.sh
- sbt run
- http://localhost:4000/assets/application.js
- http://localhost:4000/assets/application.css

