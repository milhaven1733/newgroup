README

GroupEt

Setup

```
cp config/secrets.yml.example config/secrets.yml
cp config/database.yml.example config/database.yml
bundle install
bin/rake db:create db:migrate
bin/rails s
```
