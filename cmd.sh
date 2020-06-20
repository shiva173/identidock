#!/bin/bash
set -e

if [ "$ENV" = 'DEV' ]; then
	echo "Running Development Server" # start developmend server
	exec python "identidock.py"
elif [ "$ENV" = 'UNIT' ]; then
  echo "Running Unit Tests"
  exec python "tests.py"
else
	echo "Running Production Server" # start prod server set port and remove env in docker-compose for start containers
	                                 # prod mode
	exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py \
	--callable app --stats 0.0.0.0:9191
fi
