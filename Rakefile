require_relative './app'
require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks

task :default => :migrate

desc "Run migrations"
task :migrate do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
end

desc "Send a random tweet"
task :tweet do
  Tweet.send_random_tweet
end
