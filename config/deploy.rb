# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'group'
set :repo_url, 'git@github.com:brtr/group.git'
 
# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
 
set :user, "brtr"
# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
 
# Default value for :scm is :git
set :scm, :git
 
# Default value for :format is :pretty
set :format, :pretty
 
# Default value for :log_level is :debug
# set :log_level, :debug
 
# Default value for :pty is false
# set :pty, true
 
set :bundle_without,  [:development, :test]

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml', 'config/secrets.yml', 'config/config.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
 
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
 
# Default value for keep_releases is 5
set :keep_releases, 5
 
set :use_sudo, false
set :rails_env, 'production'
set :depoly_via, :remote_cache
set :puma_config_path, -> { File.join(current_path, "config", "puma.rb") }
set :puma_pid,  -> { File.join(shared_path, "tmp", "pids", "puma.alink.pid") }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      if test "[ -f #{fetch(:puma_pid)} ]"
        execute "kill -USR2 `cat #{fetch(:puma_pid)}`"
      else
        within current_path do
          execute :bundle, "exec puma", "--config", fetch(:puma_config_path), "-e", fetch(:rails_env), "-d"
        end
      end
    end
  end
  after :publishing, :restart
  after :finishing, :cleanup
 
  desc "Init the config files in shared_path"
  task :setup_config do        
    on roles(:web), in: :sequence, wait: 5 do
      unless test "[ -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
        upload!("config/config.yml.example", "#{shared_path}/config/config.yml")
        upload!("config/secrets.yml.example", "#{shared_path}/config/secrets.yml")
        upload!("config/database.yml.example", "#{shared_path}/config/database.yml")
        upload!("config/application.yml.example", "#{shared_path}/config/application.yml")
        puts "Now edit the config files in #{shared_path}"
      end                      
    end
  end
  after "check:directories", :setup_config
end
