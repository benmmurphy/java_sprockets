#!/bin/sh
set -e

# Really dodgy way of packing gems into a jar file for jruby... Don't like mixing bundler and Java deployment

rm -rf vendor/cache
bundle package

rm -rf sprocket_gems

gem install --ignore-dependencies -f -i sprocket_gems ./vendor/cache/* --no-ri --no-rdoc

rm -f lib/sprocket_gems.jar

(cd sprocket_gems && jar cvf ../lib/sprocket_gems.jar .)
