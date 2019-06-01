# Dota Analayzer

A dota 2 containerized rails app that counts player's winrates of every hero for the last month.
### Installation

Dota Analyzer requires [Docker Desktop](https://www.docker.com/products/docker-desktop) to run.

Create an external data volume for postgres. This is not the best approach but due to [known issue](https://github.com/docker/for-win/issues/445) with Docker Desktop on Windows 10, this was the best way to create a persisting postgres database.

```sh
$ cd dota_analyzer
$ docker volume create --name=pg-db
```


If you are not using Docker Desktop on a Windows 10 host then you might want to skip creating the data volume and change the  `docker-compose.yml` to match the `db` service with the one mentioned [here](https://docs.docker.com/compose/rails/).

Create and migrate database.
```sh
$ docker-compose run web rails db:create db:migrate
```
##### Adding Steam Web API Key to Credentials:
#
Get your Steam Web API key from [here](https://steamcommunity.com/dev/apikey), You only need a Steam account for that.

Run the project.
```sh
$ docker-compose up
```
In a new terminal check for running containers.
```sh
$ docker ps
```
Attach a bash session to the `dota_analyzer_web` container.
```sh
$ docker exec -it <container_id>  /bin/bash
```
Install Nano editor inside the conrainer to edit the credentials file.
```sh
$ apt-get install nano
$ EDITOR="nano" rails credentials:edit
```
This will install Nano and open `config/credentials.yml.enc` as a `yml` file in your terminal, You should add Your Steam Web Api key in the file under the key `STEAM_WEB_API_KEY` and save it. 
I.E `STEAM_WEB_API_KEY: 49a6hd0d3900tw9cd5twe51v6070e0c1`
If You get the message `ActiveSupport::MessageEncryptor::InvalidMessage`  then You should delete both `config/credentials.yml.enc` and `config/master.key` if available and rerun the edit command.

Open rails console to get Hero Stats.
```sh
$ docker-compose run web rails console
```
Then run the job that updates the Heros table in the database.
```sh
$ UpdateHerosTable.new.perform
```
That's It use `docker-compose up` and `docker-compose down` to run or exit the server.

##### Deploying to Heroku:
#
Create a Heroku account [here](https://signup.heroku.com/) if You don't have one and log in. Then log in to heroku's container registry.
```sh
$ heroku login
$ heroku container:login
```
Navigate to the app’s directory and create a Heroku app.
```sh
$ heroku create
```
Create heroku addon postgres database.
```sh
$ heroku addons:create heroku-postgresql:hobby-dev
```
Build the image and push to container registry.
```sh
$ heroku container:push web
```
Then release the image to your app.
```sh
$ heroku container:release web
```
Run the database migrations.
```sh
$ heroku run rails db:migrate
```
Then run the job that updates the Heros table in the database.
```sh
$ heroku run rails console
$ UpdateHerosTable.new.perform
```
To run the `crono` process.
```sh
$ heroku run bundle exec crono
```
To open the app in your browser.
```sh
$ heroku open
```
If the app's `css` is not loaded.
```sh
$ heroku run rails assets:precompile
```
To read more visit Heroku's [Container Registry & Runtime (Docker Deploys)](https://devcenter.heroku.com/articles/container-registry-and-runtime)

### API
* [OpenDota](https://docs.opendota.com/) - The OpenDota API provides Dota 2 related data.
* [Dota](https://github.com/vinnicc/dota) - Ruby client for the Dota 2 WebAPI.
### Cron Jobs
Dota Analyzer uses the [crono-gem](https://github.com/plashchynski/crono) to run time-based background jobs.
|Name              |Job                                      | 
|----------------- |-----------------------------------------|
| UpdateHerosTable | Updates the Heros Stats every 12 hours  |
| UpdateUsersData  | Updates the User Stats every 2 days     |
| CleanMatchesTable| delete matches older than a month every 6 hours  |
To make changes to these jobs check the `app/jobs` folder and `config/crontab.rb` file.

### Usage
Dota Analyzer is a simple app, The user can view the `Heros stats` page which is a filterable and sortable table with the stats(number of picks and wins) of every hero in the last months collected from many public matches by [OpenDota](https://docs.opendota.com/). The user can also view his stats in a table for every hero in the last months in the `Your Stats` page. Finally the user can view the data from both tables(`Your stats` and `Hero Stats`) in a third page `Meta` to compare his winrates with the `Hero Stats`. Steam log in is required before entering `Your Stats` or `Meta`.
##### Heros Table:
#
![](https://github.com/kemega/dota_analyzer/app/assets/images/heros.png?raw=true)
##### Meta Table:
#
![](https://github.com/kemega/dota_analyzer/app/assets/images/meta.png?raw=true)

