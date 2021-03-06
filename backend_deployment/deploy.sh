#!/bin/bash
cd $TRAVIS_BUILD_DIR/server/glovo_webapi
dotnet restore
cd glovo_webapi
dotnet publish -c Release -o $TRAVIS_BUILD_DIR/backend_deployment/publish
cd $TRAVIS_BUILD_DIR/backend_deployment
dotnet ef migrations script --idempotent --project $TRAVIS_BUILD_DIR/server/glovo_webapi/glovo_webapi -o migration.sql
echo $HEROKU_API_KEY
heroku login
heroku pg:psql --app ub-es2020-glovo-webapi < migration.sql
heroku container:login
heroku container:push web -a ub-es2020-glovo-webapi
heroku container:release web -a ub-es2020-glovo-webapi
