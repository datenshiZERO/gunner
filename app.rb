Bundler.require

require 'sinatra/asset_pipeline'

class App < Sinatra::Base
  set :assets_precompile, %w(app.js mobile.js app.css *.png *.jpg *.svg *.eot *.ttf *.woff *.ogg *.mp3 *.json *.xml)
  #set :assets_host, 'datenshizero.github.io'
  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier

  #Sprockets::Helpers.prefix = "/gunner/assets"
  register Sinatra::AssetPipeline

  get '/' do
    @cocoon = false
    haml :index
  end

  get '/cocoon' do
    @cocoon = true
    haml :index
  end

  get '/mobile' do
    @mobile = true
    haml :index
  end

  get '/manifest.webapp' do
    erb :manifest
  end
end
