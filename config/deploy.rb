require 'dotenv'
Dotenv.load

# config valid for current version and patch releases of Capistrano
lock "~> 3.17.2"

server ENV['DEPLOY_SERVER_IP'], port: 22, roles: [:app, :web, :db], primary: true
set :application, "honey_pot"
set :repo_url, ENV['REPO_URL']
set :user, ENV['DEPLOY_SERVER_USER']

# Default branch is :master
set :branch, :main
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/honey_pot"

set :rvm_type, :user
set :rvm_ruby_version, '3.2.1'

set :puma_threads, [4, 16]
set :puma_workers, 0

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :bundle_jobs, 2

before 'bundler:install', 'bundle_platform:update'

namespace :puma do
  desc 'Create Directories for Puma Pid and Socket'
  task :create_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  desc 'Upload systemd unit file'
  task :upload_systemd_unit_file do
    on roles(:app) do
      template_file = File.join(File.dirname(__FILE__), 'deploy', 'templates', 'puma.service.erb')
      config_file = ERB.new(File.read(template_file)).result(binding)
      upload! StringIO.new(config_file), "/tmp/puma_#{fetch(:application)}_production.service"
      execute :sudo, "mv /tmp/puma_#{fetch(:application)}_production.service /etc/systemd/system/puma_#{fetch(:application)}_production.service"
    end
  end
end

# after 'deploy:starting', 'puma:create_dirs'
# after 'deploy:starting', 'puma:upload_systemd_unit_file'
