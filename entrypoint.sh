bundle exec rake assets:precompile

bundle exec rake db:create db:migrate

# rm -f /usr/src/app/tmp/pids/server.pid

echo "$(env)"

bundle exec rails server -b 0.0.0.0 -p 3000