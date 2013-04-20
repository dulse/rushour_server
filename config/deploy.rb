require 'bundler/capistrano'

set :stages, %w(production staging)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

role :web, 'your web-server here'
role :app, 'your app-server here'
role :db,  'your primary db-server here', :primary => true
role :db,  'your slave db-server here'

set :application, 'rushour'
set :repository,  'set your repository location here'
set :scm, :git
set :use_sudo, false

set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :deploy_env, 'production'
set :keep_releases, 5

set :unicorn_binary, 'bundle exec unicorn'
set :unicorn_config, "#{current_path}/config/unicorn.conf.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

ssh_options[:forward_agent] = true

desc "asks for confirmation before deploying to production"
task :confirm_production do
  if stage == :production
    $stdout.sync = true
    confirm_string = 'HELL YEA!'
    puts 'You are asking to deploy to production.'
    puts 'Are you sure you want to do this?'
    puts "If yes, please type #{confirm_string}: "
    answer = STDIN.gets.chomp

    unless answer == confirm_string
      puts "You said ('#{answer}') -- aborting!"
      exit 1
    end
  end
end

namespace :deploy do
  desc "start unicorn"
  task :start, :roles => :utility do
    run "cd #{current_path} && RACK_ENV=#{stage} #{unicorn_binary} -c #{unicorn_config} -D"
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
        run "(cd #{current_path} && RACK_ENV=#{stage} #{unicorn_binary} -c #{unicorn_config} -D)"
      else
        run "kill -s USR2 `cat #{unicorn_pid}`"
      end
    end
  end
end

before 'deploy', 'confirm_production'
before 'deploy:finalize_update', 'bundle:install'
