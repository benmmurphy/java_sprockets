#!/bin/bash
sprockets -r sass -r coffee-script -I src/main/webapp/app/assets/javascripts -I src/main/webapp/app/assets/stylesheets -o gen_assets src/main/webapp/app/assets/javascripts/application.js src/main/webapp/app/assets/stylesheets/application.scss
