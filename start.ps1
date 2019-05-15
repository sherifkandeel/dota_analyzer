Set-Location c:\users\kemeg\desktop\dota_analyzer
invoke-expression 'cmd /c start powershell -Command { docker-compose run web bundle exec crono RAILS_ENV=development}'
docker-compose up
