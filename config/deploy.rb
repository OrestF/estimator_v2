# config valid for current version and patch releases of Capistrano
lock "~> 3.12.0"

# Main settings
# See https://github.com/capistrano/rails
set :application,             'project_name'
set :pty,                     true
set :use_sudo,                true
set :deploy_via,              :remote_cache
set :ssh_options,             { forward_agent: true, user: fetch(:user) }
set :deploy_to,               "/var/www/#{fetch(:application)}"
set :assets_roles,            :app
set :migration_role,          :app
set :linked_dirs,             %w{log, tmp/pids, tmp/cache, tmp/sockets, vendor/bundle, .bundle, public/system, public/uploads}
set :linked_files,            %w{config/master.key config/database.yml config/credentials/production.yml}

# Sidekiq setting
# See https://github.com/seuros/capistrano-sidekiq
set :sidekiq_roles,            :app
set :sidekiq_config,           "#{current_path}/config/sidekiq.yml"

# Puma settings see:
# See https://github.com/seuros/capistrano-puma
set :puma_threads,            [4, 16]
set :puma_workers,            0
set :puma_bind,               "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,              "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,                "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log,         "#{release_path}/log/puma.error.log"
set :puma_error_log,          "#{release_path}/log/puma.access.log"
set :puma_preload_app,        true
set :puma_worker_timeout,     nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord

namespace :puma do
    desc 'Create Directories for Puma Pids and Socket'
    task :make_dirs do
      on roles(:app) do
        execute "mkdir #{shared_path}/tmp/sockets -p"
        execute "mkdir #{shared_path}/tmp/pids -p"
      end
    end
    before :start, :make_dirs
  end
  
namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
        puts "WARNING: HEAD is not the same as origin/#{fetch(:branch)}"
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end
  
  desc 'Restart application'
  task :restart_puma do
    on roles(:app) do
        execute :sudo, :systemctl, :restart, :puma
    end
  end

  desc 'Restart sidekiq'
  task :restart_sidekiq do
    on roles(:app) do
        execute :sudo, :systemctl, :restart, :sidekiq
    end
  end

  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart_puma
  after  :finishing,    :restart_sidekiq
end