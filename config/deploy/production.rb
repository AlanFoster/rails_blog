set :stage, :production
set :branch, 'master'
set :rails_env, :production

set :server_name, '107.155.101.154'
server fetch(:server_name), user: 'deploy', roles: %i(web app), primary: true

set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey password)
}