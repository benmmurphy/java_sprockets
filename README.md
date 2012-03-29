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
- http://localhost:4000
- http://localhost:4000/assets/application.js
- http://localhost:4000/assets/application.css

# Statically Compiling Assets

    ./compile.sh
    
There is no magic to serve the statically compiled assets. Have a look at sinatra sprockets to see how to do this (https://github.com/thegorgon/sinatra-sprockets).

#Info

We use bundler install gems and package them up into a jar file in the lib directory. If you save the contents of this
file you don't need to install jruby. JRuby is only necessary to run bundler.
