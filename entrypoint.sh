#!/bin/bash
set -e
RAILS_ENV=${RAILS_ENV:=development}
DATABASE_URL=${DATABASE_URL:=db}
PORT=${PORT:=3000}
rm -f tmp/pids/server.pid
exec "$@"