bundle exec rake assets:precompile

bundle exec rake db:create db:migrate

bundle exec rails server -b 0.0.0.0 -p 3000