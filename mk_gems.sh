#!/bin/sh
set -e

# Really dodgy way of packing gems  for jruby... Don't like mixing bundler and Java deployment
export JRUBY_OPTS=--1.9
rm -rf sprocket_gems
bundle install --system
bundle package
bundle install --local --path sprocket_gems
rm -rf src/main/webapp/WEB-INF/gems
mv sprocket_gems/jruby/1.9 src/main/webapp/WEB-INF/gems

