# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
# require 'capistrano/npm'

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require 'capistrano/puma'
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Daemon

# Depending on your server, you may need a different plugin
# For a Digital Ocean deploy, 'Daemon' will work
# Documentation: https://github.com/seuros/capistrano-puma
# From the documentation: "If you using puma daemonized (not supported in Puma 5+)""
# install_plugin Capistrano::Puma::Daemon

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }