require 'bundler/capistrano'

set :application, 'rushour'
set :repository,  'git@github.com:mooremo/rushour_server.git'
set :scm, :git
set :user, 'ubuntu'
server 'ec2-23-23-12-82.compute-1.amazonaws.com', :app, :web, :db, :primary => true
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = ['publickey']
ssh_options[:keys] = ['/Users/mmoore/Documents/Projects/rushour_server/config/rushour.pem']
set :use_sudo, true

set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :deploy_env, 'production'
set :keep_releases, 5

set :unicorn_binary, 'bundle exec unicorn'
set :unicorn_config, "#{current_path}/config/unicorn.conf.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

namespace :deploy do
  desc "start unicorn"
  task :start, :roles => :utility do
    run "cd #{current_path} && RACK_ENV=#{deploy_env} #{unicorn_binary} -c #{unicorn_config} -D"
  end

  desc "stop unicorn"
  task :stop, :roles => :utility do
    run "kill -s KILL `cat #{unicorn_pid}` || true"
  end

  desc "rereads unicorn config files"
  task :reread_config, :roles => :utility do
    run "kill -s HUP `cat #{unicorn_pid}` || true"
  end

  desc "gracefully stop unicorn"
  task :graceful_stop, :roles => :utility do
    run "kill -s QUIT `cat #{unicorn_pid}` || true"
  end

  desc "gracefully stop/start unicorn (execs new unicorn instance, old one times out)"
  task :restart, :roles => :utility do
    roles[:utility].instance_variable_get('@static_servers').each do |host|
      if unicorn_pids_by_host[host].empty?
        run "(cd #{current_path} && RACK_ENV=#{deploy_env} #{unicorn_binary} -c #{unicorn_config} -D)"
      else
        run "kill -s USR2 `cat #{unicorn_pid}`"
      end
    end
  end
end

before 'deploy:finalize_update', 'bundle:install'
