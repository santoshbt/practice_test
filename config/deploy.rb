server "16.202.8.57"
set :user, "turamari"

set :application, "webapp"

set :scm, :git
set :repo_url,  "git@github.com:santoshbt/practice_test.git"
set :deploy_to, "/opt/mount1/appstore/practice_test"

set :ssh_options, {
  forward_agent: true
}

set :log_level, :info

set :linked_files, %w{config/database.yml config/config.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system}

SSHKit.config.command_map[:rake]  = "bundle exec rake" #8
SSHKit.config.command_map[:rails] = "bundle exec rails"

set :keep_releases, 20

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("/opt/mount1/appstore/restart.txt")
    end
  end

  after :finishing, "deploy:cleanup"

end

# task :hello do
# 	# puts "Hello #{fetch(:recipient, "World")}"
# 	on roles :all do
# 		execute "echo 'Hello World' > ~/hello"
# 	end
# end