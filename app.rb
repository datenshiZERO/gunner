Bundler.require

require 'sinatra/asset_pipeline'

class App < Sinatra::Base
  set :assets_host, 'bryanbibat.net'
  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier

  register Sinatra::AssetPipeline

  get '/' do
    haml :index
  end
end
