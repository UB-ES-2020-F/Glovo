#!/bin/bash
cd $TRAVIS_BUILD_DIR/frontend/customerapp
flutter build web
cp -r web $TRAVIS_BUILD_DIR/frontend_deployment/web
cd $TRAVIS_BUILD_DIR/frontend_deployment
git init
heroku git:remote -a ub-es2020-glovo
git add .
git commit -am "deploy"
git push heroku master
