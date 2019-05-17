#!/bin/bash
set -e
bin/rails db:create
bin/rails db:migrate
rm -f tmp/pids/server.pid
exec "$@"
    