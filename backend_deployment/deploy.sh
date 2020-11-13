#!/bin/bash
cd $TRAVIS_BUILD_DIR/backend_deployment
dotnet ef migrations script --idempotent --project $TRAVIS_BUILD_DIR/server/glovo_webapi/glovo_webapi -o migration.sql
heroku pg:psql --app ub-es2020-glovo-webapi < migration.sql
heroku container:login
heroku container:push web -a ub-es-2020-glovo-webapi
heroku container:release web -a ub-es-2020-glovo-webapi
