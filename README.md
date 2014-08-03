# Unnamed Shooting Game

Play the game at http://datenshizero.github.io/gunner/

## Development

This game requires Ruby 2.1 and Bundler.

Install dependencies via:

    $ bundle install

Run the [LiveReload](https://github.com/johnbintz/rack-livereload) enabled server via:

    $ bundle exec guard

To compile assets with [`sinatra-asset-pipeline`](https://github.com/kalasjocke/sinatra-asset-pipeline):

    $ RACK_ENV=production bundle exec rake assets:precompile
