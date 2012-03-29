require 'rubygems'
require 'sprockets'
require 'sass'
require 'coffee_script'
require 'eco'

map '/assets' do
  root = File.dirname(__FILE__)
  environment = Sprockets::Environment.new
  environment.append_path File.join(root, '/app/assets/javascripts')
  environment.append_path File.join(root, '/app/assets/stylesheets')
  run environment
end

