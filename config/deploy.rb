#========================
#CONFIG
#========================
set :application, "whatthefuckshouldihaveforlunch.com"
set :scm, :git
set :git_enable_submodules, 1
set :repository, "git://github.com/lindsayevans/whatthefuckshouldihaveforlunch.com.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }
set :stage, :production
set :user, "lindsay"
set :use_sudo, true
set :runner, "lindsay"
set :deploy_to, "/var/www/#{application}"
set :app_server, :passenger
#set :domain, "whatthefuckshouldihaveforlunch.com"
set :domain, "linz.id.au"

#========================
#ROLES
#========================
role :app, domain
role :web, domain
role :db, domain, :primary => true

#========================
#CUSTOM
#========================
namespace :deploy do
    task :start, :roles => :app do
	run "touch #{current_release}/tmp/restart.txt"
    end
    task :stop, :roles => :app do
	# Do nothing.
    end
    desc "Restart Application"
    task :restart, :roles => :app do
	run "touch #{current_release}/tmp/restart.txt"
    end
end


