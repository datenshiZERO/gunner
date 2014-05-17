unless ENV['RACK_ENV'] == 'production'
  require 'rack-livereload'
  use Rack::LiveReload
end
require './app'
run App
