README

GroupEt

Setup

```
cp config/secrets.yml.example config/secrets.yml
cp config/database.yml.example config/database.yml
cp config/application.yml.example config/application.yml
cp config/config.yml.example config/config.yml

bundle install
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
bin/rake db:create db:migrate
bin/rails s
```
