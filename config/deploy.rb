require 'mina/bundler'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'games.bryanbibat.net'
set :deploy_to, '/home/deploy/habagat'
set :repository, 'https://github.com/datenshiZERO/gunner.git'
set :branch, 'master'

set :user, 'deploy'    # Username in the server to SSH to.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  queue "export RACK_ENV=production"
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue "mkdir -p /home/deploy/habagat"
  queue "mkdir -p /home/deploy/games/assets"
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'bundle:install'

    to :launch do
      queue "bundle exec rake assets:precompile"
      queue "ln -sf #{deploy_to}/#{current_path}/public/assets /home/deploy/games/assets/habagat"
      queue "bundle exec ruby generator.rb"
      queue "ln -sf #{deploy_to}/#{current_path}/public /home/deploy/games/habagat"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

