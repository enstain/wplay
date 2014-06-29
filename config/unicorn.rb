rails_env = 'production'

worker_processes 3
timeout 30
listen 16002
#user('www-data', 'www-data')
pid './tmp/pids/unicorn.pid'

require 'bundler'

after_fork do |server, worker|
  ::Bundler.setup
end