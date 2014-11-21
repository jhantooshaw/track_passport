require 'bundler/capistrano'

set :domain, "54.148.21.147"
set :user, "neovision"
set :password, "ne0v1$10n"
set :application, "track_passport"
set :repository,  "git@github.com:jhantooshaw/track_passport.git"
set :rails_env, "production"
set :scm, :git
set :scm_username, "jhantooshaw"
set :deploy_to, "/home/neovision/rails_app/#{application}" 
set :use_sudo, false
set :chmod755, "app config db db/* log/production.log vendor script script/* public"
set :keep_releases, 3 

default_run_options[:pty] = true
ssh_options[:keys] = %w(~/.ssh/id_rsa)
ssh_options[:forward_agent] = true
role :app, domain
role :web, domain
role :db,  domain, :primary => true

after "deploy:restart", "deploy:cleanup"
#after "deploy:finalize_update", "deploy:assets:precompile"
#after "deploy", "deploy:restart"

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if releases.length <= 1 || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
  
  desc "Restart passenger app"
  task :restart do    
    run "touch #{File.join(current_path, 'tmp', 'restart.txt') }"
  end  
  
end