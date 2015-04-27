# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'rails_blog'

set :scm, :git
set :repo_url, 'git@github.com:AlanFoster/rails_blog.git'

set :deploy_to, '/srv/rails_blog'
set :deploy_user, 'deploy'
set :deploy_via, :copy
# set :linked_filed, %w(config/database.yml)

set :use_sudo, false

set :nvm_node, 'v0.10.38'

set :tests, []
set :bower_roles, :app
set :bower_flags, ''
set :bower_bin, "/home/deploy/.nvm/#{fetch(:nvm_node)}/bin/bower"
set :assets_roles, %i(web app)

namespace :deploy do
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'	
end